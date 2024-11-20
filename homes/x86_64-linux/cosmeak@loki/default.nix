{ lib, pkgs, inputs, namespace, config, ... }:
with lib;
with lib.${namespace};
{
    home.packages = with pkgs; with inputs; [
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
        obsidian
        php83
        php83Packages.composer
        prismlauncher
	python310
        spotify
        termius
        thunderbird
        unzip
        vesktop
        vscodium
        zed-editor
        zen-browser.packages.${system}.specific
        zip
    ];

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build. Don't ask questions.
    home.stateVersion = "24.05";
}
