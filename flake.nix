{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
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
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # The name "snowfall-lib" is required due to how Snowfall Lib processes your
        # flake's inputs.
        snowfall-lib = {
            url = "github:snowfallorg/lib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = inputs : inputs.snowfall-lib.mkFlake  {
        inherit inputs;
        src = ./.;
        snowfall.namespace = "asgard";
        snowfall.meta.name = "asgard";
        snowfall.meta.description = "Domain of the Aesir";

        channels-config.allowUnfree = true;

        systems.modules.nixos = with inputs; [
            # home-manager.nixosModules.home-manager
        ];

        systems.modules.darwin = with inputs; [
            # home-manager.darwinModules.home-manager
        ];

        systems.hosts.vali.modules = with inputs; [
            nixos-wsl.nixosModules.wsl
        ];
    };
}
