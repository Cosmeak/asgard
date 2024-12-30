{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dwl
    wmenu
  ];

  programs.waybar.enable = true;
  programs.foot.enable = true;
}
