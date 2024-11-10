{ lib, pkgs, inputs, namespace, config, ... }:
with lib;
with lib.${namespace};
{
    home.packages = with pkgs; [
        brave
        btop
        # discord
        deno
        github-desktop
        just
        lazygit
        lutris
        modrinth-app
        nodejs_20
        obs-studio
        php83
        php83Packages.composer
        spotify
        termius
        thunderbird
        unzip
        vesktop
        vscode
        zed-editor
        zip
    ];

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build. Don't ask questions.
    home.stateVersion = "24.05";
}
