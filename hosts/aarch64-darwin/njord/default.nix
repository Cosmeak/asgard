{ self, inputs, outputs, pkgs, ... }:
{
    imports = [
        ./homebrew
        ./system
    ];

    # Enable sudo via TouchID
    security.pam.enableSudoTouchIdAuth = true;

    # move this shit inside home 
    environment.systemPackages = with pkgs; [
        #  most used Dev environment
        php83
        php83Packages.composer
        nodejs_20
        python310
        vscodium      

        # CLI
        neovim
        starship
        zoxide
        tree
        btop
        lazygit
        ngrok
        fastfetch

        # Utilities
        kitty
        alt-tab-macos
        raycast
    ];

    programs.zsh = {
        enable = true;
        enableBashCompletion = true;
        enableCompletion = true;
        enableSyntaxHighlighting = true;
        loginShellInit = ''
            eval "$(zoxide init zsh)"
            eval "$(/opt/homebrew/bin/brew shellenv)"
            alias rebuild="darwin-rebuild switch --flake ~/.dotfiles"
        '';
    };

    # Garbage collector
    nix.gc = {
        automatic = true;
        interval = [{ Weekly = 7; }];
        options = "--delete-older-than 7d";
    };
    nix.settings.auto-optimise-store = true;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Use nix as a daemon
    services.nix-daemon.enable = true;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 5;
}
