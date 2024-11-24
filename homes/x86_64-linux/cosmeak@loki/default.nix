{ lib, pkgs, inputs, namespace, config, ... }:
with lib;
with lib.${namespace};
{
    home.packages = with pkgs; with inputs; [
        brave
        btop
        just
        lazygit
        lutris
        obs-studio
        obsidian
        prismlauncher
        spotify
        thunderbird
        vesktop
        vscodium
        zed-editor
        zen-browser.packages.${system}.specific
    ];

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build. Don't ask questions.
    home.stateVersion = "24.05";
}
