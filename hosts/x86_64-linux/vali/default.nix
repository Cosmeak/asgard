# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{ config, lib, pkgs, ... }:
{
  imports = [
    inputs.wsl.nixosModules.wsl
  ];

  wsl.enable = true;
  wsl.defaultUser = "vali";

  environment.systemPackages = with pkgs; [
    wget
    git
    lazygit
    php83
    php83Packages.composer
    nodejs_20
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
