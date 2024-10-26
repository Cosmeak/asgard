{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos/sound.nix
    ./../../modules/nixos/graphics/nvidia.nix
    ./../../modules/nixos/desktops/budgie.nix
    ./../../modules/nixos/steam.nix
    ./../../modules/nixos/gc.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "loki";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
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

    # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "cosmeak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cosmeak = {
    isNormalUser = true;
    description = "cosmeak";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      discord
      thunderbird
      spotify
      brave
      lutris
      unstable.zed-editor
      php83
      php83Packages.composer
      nodejs_20
      lazygit
      unstable.modrinth-app
      btop
      vesktop
      zip
      unzip
      termius
      just
    ];
  };

  # Setup nixpkgs rights
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  nixpkgs.overlays = [ outputs.overlays.unstable-packages ];

  # Install packages
  environment.systemPackages = with pkgs; [
    git
    mangohud
    protonup
    kitty
    obsidian
  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # NixOS version
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
