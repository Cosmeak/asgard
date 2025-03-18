{ self, inputs, pkgs, hostname, ... }:
{
  # WSL configuration
  wsl.enable = true;
  wsl.docker-desktop.enable = true;

  # Networking
  networking.hostName = hostname;

  # Global packages
  environment.systemPackages = with pkgs; [
    git
    wget
  ];

  # Required to use it as vscode remote
  programs.nix-ld = {
    enable = true;
  };

  # Emulate system for building others
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Enable flakes and other experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
