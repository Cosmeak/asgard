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

    nixConfig = {
        experimental-features = "nix-command flakes pipe-operators";
        auto-optimise-store = true;
    };

    outputs = { self, nixpkgs, darwin, ... }@inputs:
    let inherit (self) outputs; lib = import ./lib { inherit self inputs; }; in
    { overlays = import ./overlays { inherit inputs outputs; }; }
    # // (lib.host.mkHosts);

    // (lib.host.mkHost { system = "x86_64-linux"; hostname = "loki"; path = ./hosts/x86_64-linux/loki/default.nix; })
    // (lib.host.mkHost { system = "aarch64-darwin"; hostname = "njord"; path = ./hosts/aarch64-darwin/njord/default.nix; });
}
