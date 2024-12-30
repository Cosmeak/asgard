{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
        unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows= "nixpkgs";
        };

        # wsl = {
        #     url = "github:nix-community/NixOS-WSL";
        #     inputs.nixpkgs.follows= "nixpkgs";
        # };

        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # microvm = {
        #     url = "github:astro/microvm.nix";
        #     inputs.nixpkgs.url = "nixpkgs";
        # };

        hardware.url = "github:NixOS/nixos-hardware/master";
    };
    
    outputs = { self, nixpkgs, darwin, ... }@inputs:
    let inherit (self) outputs; in   
    {
        overlays = import ./overlays { inherit inputs outputs; };

        nixosConfigurations = {
            loki = nixpkgs.lib.nixosSystem {
		        system = "x86_64-linux";
                specialArgs = { inherit inputs self; }; 
                modules = [
                    ./hosts/x86_64-linux/loki
                    ./modules/nixos/desktop/dwl
                ];
            };

            # TODO: rework configuration not being usable at the moment
            # nyx = nixpkgs.lib.nixosSystem {
            #     specialArgs = { inherit inputs; };
            #     modules = [ ./hosts/x86_64-linux/nyx ];
            # };

            # vali = nixpkgs.lib.nixosSystem {
            #     system = "x86_64-linux";
            #     specialArgs = { inherit inputs; };
            #      modules = [ ./hosts/x86_64-linux/vali ];
            # };

            # Raspberry Pi 3b+
            # narfi = nixpkgs.lib.nixosSystem {
            #     specialArgs = { inherit inputs; };
            #     modules = [
            #         inputs.microvm.nixosModules.host
            #         ./hosts/aarch64-linux/nyx
            #     ];
            # };
        };

        darwinConfigurations = {
            njord = darwin.lib.darwinSystem {
                system = "aarch64-darwin";
                specialArgs = { inherit inputs; };
                modules = [ ./hosts/aarch64-darwin/njord ];
            };
        };
    };
}
