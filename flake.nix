{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
        unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        darwin.url = "github:LnL7/nix-darwin";
        darwin.inputs.nixpkgs.follows= "nixpkgs";

        # wsl.url = "github:nix-community/NixOS-WSL";
        # wsl.inputs.nixpkgs.follows= "nixpkgs";

        # hardware.url = "github:NixOS/nixos-hardware/master";

        # microvm.url = "github:astro/microvm.nix";
        # microvm.inputs.nixpkgs.url = "nixpkgs";

        home-manager.url = "github:nix-community/home-manager/release-24.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        
        zen-browser.url = "github:0xc000022070/zen-browser-flake";
    };
    
    outputs = { self, nixpkgs, darwin, ... }@inputs:
    let inherit (self) outputs; lib = import ./lib { inherit self inputs; }; in   
    {
        overlays = import ./overlays { inherit inputs outputs; };

        nixosConfigurations = {
            # loki = nixpkgs.lib.nixosSystem {
		    #     system = "x86_64-linux";
            #     specialArgs = { inherit inputs self; }; 
            #     modules = [ ./hosts/x86_64-linux/loki ];
            # };

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
            #     modules = [ ./hosts/aarch64-linux/nyx ];
            # };
        };

        darwinConfigurations = {
            njord = darwin.lib.darwinSystem {
                system = "aarch64-darwin";
                specialArgs = { inherit inputs; };
                modules = [ ./hosts/aarch64-darwin/njord ];
            };
        };
    } // (lib.host.mkHost { system = "x86_64-linux"; hostname = "loki"; path = ./hosts/x86_64-linux/loki/default.nix; });
}
