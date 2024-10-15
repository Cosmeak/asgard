{ inputs, ... }:
{
    # The unstable nixpkgs set (declared in the flake inputs) will
    # be accessible through `pkgs.unstable`
    unstable-packages = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
            inherit (final) system;
            config.allowUnfree = true;
        };
    };
}
