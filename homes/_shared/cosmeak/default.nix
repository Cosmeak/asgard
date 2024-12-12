{ inputs, pkgs, ...}:
{
  home.packages = with pkgs; [
    bat
    eza
    fzf
    zoxide
    tree
  ];

  programs.git = {
    enable = true;
    userName = "cosmeak";
    userEmail = "90453342+Cosmeak@users.noreply.github.com";
    lfs.enable = true;

    ignores = [ ".DS_STORE" ];

    extraConfig = {
      core.editor = "codium";
      pull.rebase = true;
    };
  };

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
}
