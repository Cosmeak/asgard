{ self, inputs, pkgs, hostname, ... }:
{
  imports = [
    ./hardware.nix

    # Import users
    ../../../homes/cosmeak/hydrogen
  ];

  # EFI Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  # Locales
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Timezone
  time.timeZone = "Europe/Paris";

  # Keyboard
  services.xserver.xkb.layout = "us";

  # Audio
  gems.hardware.audio.enable = true;

  # Nvidia GPU and OpenGL
  gems.hardware.nvidia.enable = true;

  # Networking
  networking.networkmanager.enable = true;
  networking.hostName = hostname;

  # Desktop Environment
  services.xserver.enable = true;
  services.xserver.desktopManager.budgie.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.displayManager.defaultSession = "budgie-desktop";
  environment.budgie.excludePackages = with pkgs; [
    mate.mate-terminal # don't need since we have kitty installed
  ];

  # Global packages
  environment.systemPackages = with pkgs; [
    firefox
    kitty
    bat
    eza
    fzf
    zoxide
    tree
    git
    starship
    pavucontrol
    unzip
    zip
  ];

  # Steam
  gems.programs.steam.enable = true;

  # Disable CUPS since this desktop will not print something.
  services.printing.enable = false;

  # Common system configurations
  gems.system.garbageCollector.enable = true;
  gems.system.autoUpdate.enable = false;

  # Enable unfree packages
  nixpkgs.config.allowUnfree = true;

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
