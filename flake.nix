{
    description = "Milkyway flakes configurations";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows= "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, darwin, home-manager, ... }:
    let
        inherit (self) outputs;
        # Currently supported systems
        systems = [
            "x86_64-linux"
            "aarch64-darwin"
        ];

        # Function to generate an attribute for all systems
        forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
        # Enable formatter
        formatter = forAllSystems (system: nixpkgs.legagyPackages.${system}.alejandra);

        # Applied overlays
        overlays = import ./overlays { inherit inputs; };

        nixosConfigurations = {
            loki = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs outputs; };
                modules = [
                    ./hosts/loki/configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users = {
                            cosmeak = import ./homes/cosmeak-loki/home.nix;
                        };
                    }
                ];
            };

            nyx = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs outputs; };
                modules = [ ./hosts/nyx/configuration.nix ];
            };
        };

        darwinConfigurations = {
            njord = darwin.lib.darwinSystem {
                specialArgs = { inherit inputs outputs; };
                modules = [ ./hosts/njord/configuration.nix ];
            };
        };
    };
}
