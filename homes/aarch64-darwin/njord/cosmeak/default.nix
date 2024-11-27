{ inputs, pkgs, ... }:
{
    imports = [ 
        # TODO: Add shared config
     ];

    home.username = "cosmeak";
    home.homeDirectory = "/Users/cosmeak";
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
        #  most used Dev environment
        php83
        php83Packages.composer
        nodejs_20
        python310      

        # CLI
        neovim
        tree
        btop
        lazygit
        ngrok
        fastfetch

        # Utilities
        alt-tab-macos
        raycast
    ];

    programs.kitty = {
        enable = true;
        shellIntegration.enableZshIntegration = true;
        themeFile = "Monokai_Pro";
    };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        initExtra = ''
            eval "$(zoxide init zsh)"
            eval "$(/opt/homebrew/bin/brew shellenv)"
            alias rebuild="darwin-rebuild switch --flake ~/.dotfiles"
        '';
    };

    programs.starship = {
        enable = true;
        enableZshIntegration = true;
    };

    programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
    };

    home.file.".config/aerospace/aerospace.toml".source = ./i3-like.toml;

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    home.stateVersion = "24.05";
}
