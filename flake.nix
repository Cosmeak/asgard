{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
        unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows= "nixpkgs";
        };

        nixos-wsl = {
            url = "github:nix-community/NixOS-WSL";
            inputs.nixpkgs.follows= "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # The name "snowfall-lib" is required due to how Snowfall Lib processes your
        # flake's inputs.
        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # Additionnal pkgs
        zen-browser.url = "github:0xc000022070/zen-browser-flake";
        # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };
    outputs = inputs : inputs.snowfall-lib.mkFlake  {
        inherit inputs;
        src = ./.;
        snowfall.namespace = "asgard";
        snowfall.meta.name = "asgard";
        snowfall.meta.description = "Domain of the Aesir";

        channels-config.allowUnfree = true;
        channels-config.allowBroken = true;

        systems.modules.nixos = with inputs; [
            home-manager.nixosModules.home-manager
        ];

        systems.modules.darwin = with inputs; [
            home-manager.darwinModules.home-manager
        ];

        homes.modules = with inputs; [
            # inputs.chaotic.homeManagerModules.default
        ];

        systems.hosts.vali.modules = with inputs; [
            nixos-wsl.nixosModules.wsl
        ];
    };
}
