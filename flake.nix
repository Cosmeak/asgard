{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
        unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows= "nixpkgs";
        };

        wsl = {
            url = "github:nix-community/NixOS-WSL";
            inputs.nixpkgs.follows= "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        microvm = {
            url = "github:astro/microvm.nix";
            inputs.nixpkgs.url = "nixpkgs";
        };

        hardware.url = "github:NixOS/nixos-hardware/master";
    };
    
    outputs = { self, nixpkgs, darwin, wsl, home-manager, microvm, hardware, ... }@inputs:   
    {
        # overlays = import ./overlays { inherit inputs; };

        nixosConfigurations = {
            loki = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs; }; 
                modules = [
                    home-manager.nixosModules.home-manager
                    ./hosts/x86_64-linux/loki

                    # This below is for testing purpose before putting up my homelab
                    # microvm.nixosModules.host
                    # {
                    #     microvm.autostart = [
                    #         "forjego"
                    #     ];

                    #     microvm.vms = {
                    #         forgejo = {
                    #             pkgs = import nixpkgs { system = "x86_64-linux"; };

                    #             config = {
                    #                 microvm.share = [
                    #                     {
                    #                         source = "/nix/store";
                    #                         mountPoint = "/nix/.ro-store";
                    #                         tag = "ro-store";
                    #                         proto = "virtiofs";
                    #                     }
                    #                 ];

                    #                 services.forgejo = {
                    #                     package = pkgs.forgejo;
                    #                     enable = true;
                    #                     lfs.enable = true;
                    #                     settings.service.DISABLE_REGISTRATION = true;
                    #                 };
                    #             };
                    #         };
                    #     };
                    # }
                ];
            };

            vali = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                 modules = [
                    wsl.nixosModules.wsl
                    home-manager.nixosModules.home-manager
                    ./hosts/x86_64-linux/vali
                ];
            };

            nyx = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs; };
                modules = [
                    home-manager.nixosModules.home-manager
                    ./hosts/x86_64-linux/nyx
                ];
            };

            # Raspberry Pi 3b+
            narfi = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs; };
                modules = [
                    microvm.nixosModules.host
                    ./hosts/aarch64-linux/nyx
                ];
            };
        };

        darwinConfigurations = {
            njord = darwin.lib.darwinSystem {
                system = "aarch64-darwin";
                specialArgs = { inherit inputs; };
                modules = [ 
                    ./hosts/aarch64-darwin/njord
                    home-manager.darwinModules.home-manager
                ];
            };
        };
    };
}
