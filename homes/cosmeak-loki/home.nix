{ inputs, outputs, pkgs, ... }:
{
    home.username = "cosmeak";
    home.homeDirectory = "/home/cosmeak";

    home.packages = with pkgs; [
        hello
    ];

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    home.stateVersion = "24.05";
}
