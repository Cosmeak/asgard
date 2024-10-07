{
    description = "Milkyway flakes configurations";

    inputs = {
        # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows= "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, darwin, ... }:
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

        nixosConfigurations = {
            loki = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs outputs; };
                modules = [ ./hosts/loki/configuration.nix ];
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
