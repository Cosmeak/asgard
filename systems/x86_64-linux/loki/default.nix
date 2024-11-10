{ lib, pkgs, inputs, namespace, system, target, format, virtual, systems, config, ... }:
with lib;
with lib.${namespace};
{
    imports = [ ./hardware.nix ];

    asgard = {
        system = {
            boot.efi.enable = true;
            fonts.enable = true;

            time.enable = true;
            locale.enable = true;

            xkb.enable = true;

            shell.enable = true;
        };

        hardware = {
            gpu.nvidia.enable = true;
            audio.enable = true;
            networking.enable = true;
        };

        desktop.budgie.enable = true;

        apps = {
            steam.enable = true;
        };
    };

    # Enable automatic login for the user.
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "cosmeak";

    # Install packages
    environment.systemPackages = with pkgs; [
        git
        mangohud
        protonup
        kitty
        obsidian
    ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.cosmeak = {
        isNormalUser = true;
        description = "cosmeak";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    # Enable or not CUPS to print documents.
    services.printing.enable = false;

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
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
}
