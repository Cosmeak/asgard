{ inputs, pkgs, ... }:
{
    imports = [ ./../../../_shared/cosmeak ./river ./waybar ];

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
        btop
	    discord
        just
        lazygit
        lutris
        obs-studio
        obsidian
        prismlauncher
        spotify
        thunderbird
        vscodium
        bottles
        _1password-gui
    ];

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build. Don't ask questions.
    home.stateVersion = "24.11";
}
