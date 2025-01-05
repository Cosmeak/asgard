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
      hostsInformations = builtins.map mkHostInformations hosts;
    in hostsInformations;

    ## Get the name of the system output
    #@ String -> String
    getOutput = system: if system |> isDarwin then "darwinConfigurations" else "nixosConfigurations";

    ## Get the system host builder
    #@ String -> Functions
    getBuilder = system: let
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
      builder ? getBuilder system,
      output ? getOutput system
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
      architecturesPath = ./../hosts;
      # Get the architecture directories
      architectures = fs.getDirectories architecturesPath;

      # Collect all hosts by iterating over architectures
      allHosts = lib.map (architecture: let
        # Get host directories for this architecture
        hostDirectories = fs.getDirectories "${architecturesPath}/${architecture}";

        # Generate the host information for each directory
        hostInfos = lib.map (hostDir: getSystemHostsInformations hostDir) hostDirectories;

        # Create a host configuration for each host information
        hostConfigs = lib.map (hostInfo: mkHost {
          system = hostInfo.system;  # The system (architecture) for the host
          hostname = hostInfo.hostname;
          path = hostInfo.path;
        }) hostInfos;
      in hostConfigs) architectures;
    in lib.foldl' (attrs: newAttrs: attrs // newAttrs) {} allHosts;
  };

  ## Home
  ## Help me manage creation of all users home by host
  home = rec {
    ## Create home modules for a user
    #@ Attrs -> []Module
    mkHome = {
      system,
      hostname,
      username,
      stateVersion ? "24.11"
    }:
    [
      (if system |> host.isDarwin then inputs.home-manager.darwinModules.home-manager else inputs.home-manager.nixosModules.home-manager)
      {
        inputs.home-manager.useGlobalPkgs = true;
        inputs.home-manager.useUserPackages = true;
        inputs.home-manager.extraSpecialArgs = { inherit system hostname username; };
        inputs.home-manager.${username} = {
          imports = [ ./homes/${system}/${hostname}/${username}/default.nix ] ++ module.getHomeManagerModules;
          programs.home-manager.enable = true; # Let home manager manage itself
          home.username = username;
          home.homeDirectory = if system |> host.isDarwin then "/Users/${username}" else "/home/${username}";
          home.stateVersion = stateVersion;
        };
      }
      # (if system |> host.isLinux then {
      #   # Define a user account. Don't forget to set a password with ‘passwd’.
      #   users.users.${username} = {
      #       isNormalUser = true;
      #       description = username;
      #       extraGroups = [ ];
      #   };
      # } else {})
    ];

    ## Create all user home from a host
    #@ Attrs -> []Modules
    mkHomes = {
      system,
      host
    }: {

    };
  };

  ## Flake output
  ## Help manage flake output creation with making available the lib, 
  ## modules, overlays and configurations.
  flake = rec {
    ## Build flake output
    mkFlake = {};
  };
}
