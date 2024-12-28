{ inputs, pkgs, ... }:
{
    imports = [ ./../../../_shared/cosmeak ];

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
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
        vscodium
    ] ++ [ inputs.ghostty.packages.x86_64-linux.default ];

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build. Don't ask questions.
    home.stateVersion = "24.11";
}
