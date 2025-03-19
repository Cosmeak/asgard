{ self, inputs, pkgs, hostname, ... }:
{
  imports = [
    ./homebrew
    ./system
  ];

  # pin nix group to already existant id
  ids.gids.nixbld = 30000;

  # Enable sudo via TouchID
  security.pam.services.sudo_local.touchIdAuth = true;

  # Networking
  networking.computerName = hostname;
  networking.hostName = hostname;

  # Timezone
  time.timeZone = "Europe/Paris";

  # System wide packages
  environment.systemPackages = with pkgs; [
    lazygit
    kitty
    just
    firefox
    spotify
    discord
    # _1password-gui
    zed-editor
    vscodium # used for jupyter notebook because not available in zed at this time
    stats # System monitoring displayed in macos top bar - will be replaced by custom script with sketchybar
  ];

  # Common system configurations
  gems.system.garbageCollector.enable = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Allow packages
  nixpkgs.config.allowUnfree = true;

  # Use nix as a daemon
  nix.enable = true;

  # Enable flakes and other experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
