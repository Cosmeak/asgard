{ inputs, outputs, ... }:
# The unstable nixpkgs set (declared in the flake inputs) will
# be accessible through `pkgs.unstable`
final: prev: {
  unstable = import inputs.unstable {
    inherit (final) system;
    config.allowUnfree = true;
  };
}