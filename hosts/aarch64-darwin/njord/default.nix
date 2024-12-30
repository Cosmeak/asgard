{ self, inputs, pkgs, ... }:
{
    imports = [
        ./homebrew
        ./system
        inputs.home-manager.darwinModules.home-manager
    ];

    # Home Manager
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.cosmeak = import ./../../../homes/aarch64-darwin/njord/cosmeak;
    users.users.cosmeak.home = "/Users/cosmeak";

    # Enable sudo via TouchID
    security.pam.enableSudoTouchIdAuth = true;

    # Use jankyboarders to see which window is in focus
    services.jankyborders = {
        enable = true;
    };

    # Use sketcybar to replace default macos bar and have something customizable
    services.sketchybar = {
        enable = true;
    };

    # System wide packages
    environment.systemPackages = with pkgs; [
        # Add packages here
    ];

    # Garbage collector
    nix.gc = {
        automatic = true;
        interval = [{ Weekday = 7; }];
        options = "--delete-older-than 7d";
    };
    nix.optimise.automatic = true;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Use nix as a daemon
    services.nix-daemon.enable = true;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 5;
}
