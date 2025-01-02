{ self, inputs, ... }:
let inherit (inputs.nixpkgs) lib; in 
rec {
  ## FileSystem
  ## Help manage file and access to it
  fs = rec {
    ## Match if type is a directory 
    #@ String -> Boolean
    isDirectory = type: type == "directory";

    ## Match if type is a file 
    #@ String -> Boolean
    isFile = type: type == "regular";

    ## Get directories at a given path
    #@ Path -> []Path
    getDirectories = path: 
      builtins.readDir path
      |> lib.filterAttrs (_: type: type |> isDirectory)
      |> lib.mapAttrsToList(name: _: "${path}/${name}");

    ## Get files at a given path
    #@ Path -> []Path
    getFiles = path:
      builtins.readDir path
      |> lib.filterAttrs (_: type: type |> isFile)
      |> lib.mapAttrsToList(name: _: "${path}/${name}");

    ## Get files in all folders at a giver path
    #@ Path -> []Path
    getFilesRecursively = path: let 
      entries = builtins.readDir path |> lib.filterAttrs (name: type: (type |> isDirectory) || (type |> isFile));
      mapFile = name: type: let
        path' = "${path}/${name}";
      in 
        if type |> isDirectory
        then getFilesRecursively path'
        else path';
      files = lib.flatten (lib.mapAttrsToList mapFile entries);
    in files;
      
    ## Get the default file in the directory if exists
    #@ Path -> Path|null
    getDefaultFile = path: let path = "${path}/default.nix"; in if builtins.pathExists path then path else null;

    ## Get all default files from a folder recursively
    #@ Path -> []Path
    getDefaultFiles = path: getFilesRecursively path |> builtins.filter (name: builtins.baseNameOf name == "default.nix");
  };

  module = rec {
    getCommonModules = fs.getDefaultFiles ./../modules/common;
    getNixosModules = fs.getDefaultFiles ./../modules/nixos ++ getCommonModules;
    getDarwinModules = fs.getDefaultFiles ./../modules/darwin ++ getCommonModules;
    getHomeManagerModules = fs.getDefaultFiles ./../modules/home-manager;
  };

  overlay = rec {
    getOverlays = [];
  };

  ## Hosts
  ## Help manage hosts builds
  host = rec {
    ## Check if a system is Linux
    #@ String -> Bool
    isLinux = lib.hasInfix "linux";

    ## Check if a system is MacOS
    #@ String -> Bool
    isDarwin = lib.hasInfix "darwin";

    ## Get structured data about all hosts for a system 
    #@ String -> [Attrs]
    getSystemHostsInformations = systemPath: let 
      hosts = fs.getDirectories systemPath;
      mkHostInformations = path: {
        system = builtins.baseNameOf systemPath;
        hostname = builtins.baseNameOf path;
        path = fs.getDefaultFile path;
      };
      hostsInformations = builtins.map hosts;
    in hostsInformations;

    ## Get the name of the system output
    #@ String -> String
    getHostSystemOutput = system: if system |> isDarwin then "darwinConfigurations" else "nixosConfigurations";

    ## Get the system host builder
    #@ String -> Functions
    getHostBuilder = system: let
      linuxBuilder = args: lib.nixosSystem (args // {
        modules = args.modules ++ module.getNixosModules;
      });
      darwinBuilder = args: inputs.darwin.lib.darwinSystem (args // {
        modules = args.modules ++ module.getDarwinModules;
      });
    in
      if system |> isDarwin
      then darwinBuilder
      else linuxBuilder;

    ## Create output for a host
    #@ Attrs -> Attrs
    mkHost = {
      system,
      hostname,
      path,
      builder ? getHostBuilder system,
      output ? getHostSystemOutput system
    }: {
      ${output}.${hostname} = builder {
        system = system;
        specialArgs = { inherit inputs self; };
        modules = [ path ];
      };
    };

    ## Create all available hosts
    #@ Attrs -> Attrs
    mkHosts = let 
      systems = fs.getDirectories ./../hosts;
      hostsInformations = lib.concatMap getSystemHostsInformations systems;
    in {

    };
  };

  ## Flake output
  ## Help manage flake output creation
  flake = rec {
    ## Build flake output
    mkFlake = {};
  };
}