{ self, inputs, pkgs, config, ... }:
{
    imports = [ 
        ./hardware.nix
        # ./../../../modules/nixos/services/window-managers/river
        inputs.home-manager.nixosModules.home-manager
    ];

    # Window manager
    services.windowManager.river.enable = true;

    # Home Manager
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.cosmeak = import ./../../../homes/x86_64-linux/loki/cosmeak { inherit inputs pkgs; };
    users.users.cosmeak.home = "/home/cosmeak";
    home-manager.backupFileExtension = "bak";

    # EFI Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 10;

    # https://github.com/NixOS/nixpkgs/blob/c32c39d6f3b1fe6514598fa40ad2cf9ce22c3fb7/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix#L66
    boot.loader.systemd-boot.editor = false;

    # Fonts
    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "Hack" ]; })
    ];
    environment.variables = {
        # Enable icons in tooling since we have nerdfonts.
        LOG_ICONS = "true";
    };

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
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    # Nvidia GPU
    # Open GL
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
        # package = config.boot.kernelPackages.nvidiaPackages.beta;
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
    };

    # Networking
    networking.networkmanager.enable = true;
    networking.hostName = "loki";

    # Steam
     programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
    };
    environment.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOS_PATHS = "/home/cosmeak/.steam/root/compatibilitytools.d";
    };

    # Shell
    users.defaultUserShell = pkgs.zsh;
    users.users.root.shell = pkgs.bashInteractive;
    programs.zsh.enable = true;

    # Enable automatic login for the user.
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "cosmeak";

    # Install packages
    environment.systemPackages = with pkgs; [
        git
        mangohud
        protonup
        vlc
        pavucontrol
        
        inputs.zen-browser.packages."${system}".default

        # For gaming purposes
        ananicy-cpp
        ananicy-rules-cachyos
    ];

    # Unlock 1password browser extension for zen
    environment.etc."1password/custom_allowed_browsers" = {
        text = ".zen-wrapped";
        mode = "0755";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.cosmeak = {
        isNormalUser = true;
        description = "cosmeak";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    # Enable or not CUPS to print documents.
    services.printing.enable = false;

    # Enable unfree packages
    nixpkgs.config.allowUnfree = true;
    # nixpkgs.overlays = [ self.outputs.overlays.unstable-packages self.outputs.overlays.dwl ];

    # Perform garbage collection weekly to maintain low disk usage
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 1w";
    };

    # Optimize storage
    # You can also manually optimize the store via:
    #    nix-store --optimise
    # Refer to the following link for more details:
    # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
    nix.settings.auto-optimise-store = true;

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11"; # Did you read the comment?
}
