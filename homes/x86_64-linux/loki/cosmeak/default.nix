{ inputs, pkgs, ... }:
{
    home.packages = with pkgs; [
        brave
        btop
	    discord-canary
        just
        lazygit
        lutris
        obs-studio
        obsidian
        prismlauncher
        spotify
        thunderbird
        # vesktop
        vscodium
        zed-editor

        # Shell
        bat
        eza
        fzf
        zoxide
        starship
        zsh
        tree
    ];

    programs.kitty = {
        enable = true;
        shellIntegration.enableZshIntegration = true;
        themeFile = "Monokai_Pro";
    };

    programs.starship = {
        enable = true;
        enableZshIntegration = true;
    };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
            ls = "eza -la --icons --no-user --no-time --git -s type";
            cat = "bat";
            cd = "z";
        };
        initExtra = ''
            eval "$(zoxide init zsh)"
        '';
    };

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build. Don't ask questions.
    home.stateVersion = "24.05";
}
