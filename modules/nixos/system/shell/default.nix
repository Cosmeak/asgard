{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.system.shell;
in
{
    options.${namespace}.system.shell = with types; {
        enable = mkBoolOpt false "Whether or not to manage shell configuration.";
    };

    config = mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            bat
            eza
            fzf
            zoxide
            starship
            zsh
            tree
        ];

        users.defaultUserShell = pkgs.zsh;
        users.users.root.shell = pkgs.bashInteractive;
        programs.zsh.enable = true;

        asgard.home.programs.starship = {
            enable = true;
            enableZshIntegration = true;
        };

        asgard.home.programs.zsh = {
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
    };
}
