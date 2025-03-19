{
  description = ''
    This configuration is the second version of all my systems, reworked from scratch with simplicity in mind.

    I take my inspiration from others people configurations, so if you want to know what inspired this, take a look a "Nix things" and "Useful dotfiles" in my stars list.
  '';

  inputs = {
    # packages
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11";

    # Special hardware
    hardware.url = "github:NixOS/nixos-hardware/master";

    # Macos modules
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows= "nixpkgs";
    };

    # WSL modules
    wsl.url = "github:nix-community/NixOS-WSL/main";

    # Gaming like a steam machine
    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Force some nix configurations globally
  nixConfig = {
    experimental-features = "nix-command flakes pipe-operators";
  };

  outputs = { self, nixpkgs, ... }@inputs :
  let
    # Custom modules
    nixosModules = [
        ./modules/nixos/hardware/nvidia
        ./modules/nixos/hardware/audio
        ./modules/nixos/programs/steam
        ./modules/nixos/system/auto-update
        ./modules/nixos/system/garbage-collector
    ];

    darwinModules = [
      ./modules/darwin/system/garbage-collector
    ];

    # Methods
    forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
  in {
    # Nixos Configurations
    nixosConfigurations = {
      # Gaming config (console like)
      hydrogen = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          hostname = "hydrogen";
        };
        modules = [
          ./config/nixos/hydrogen
          inputs.jovian.nixosModules.default
        ] ++ nixosModules;
      };

      # Little server for testing things
      beryllium = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          hostname = "beryllium";
        };
        modules = [ 
          inputs.wsl.nixosModules.default 
          ./config/nixos/beryllium 
        ] ++ nixosModules;
      };

      # Rapsberry Pi 3b+
      lithium = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs;
          hostname = "lithium";
        };
        modules = [
          ./config/nixos/lithium
          inputs.hardware.nixosModules.raspberry-pi-4
          "${nixpkgs}/nixos/modules/profiles/minimal.nix"
        ] ++ nixosModules;
      };
    };

    # Macos configurations
    darwinConfigurations = {
      # Macbook Pro M2
      helium = inputs.darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs;
          hostname = "helium";
        };
        modules = [ ./config/darwin/helium ] ++ darwinModules;
      };
    };

    # Custom images
    # images."beryllium" = (self.nixosConfiguration."beryllium".extendModules {
    #   modules = [
    #     "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
    #     {
    #       # We don't need this defaults modules
    #       disableModules = ["profiles/base.nix"];

    #       # Copy configuration files to system
    #       environment.etc."nixos".source = ./.;

    #       # Patch build images on x86-64 systems
    #       nixpkgs.config.allowUnsupportedSystem = true;
    #       nixpkgs.hostPlatform.system = "armv7l-linux";
    #       nixpkgs.buildPlatform.system = "x86_64-linux";
    #     }
    #   ];
    # }).config.system.build.sdImage;
    #

    # Development shells
    devShells = forAllSystems(system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
        {
          default = pkgs.mkShell ({
            buildInputs = with pkgs; [ just nixd ];
          });
        }
    );
  };
}
