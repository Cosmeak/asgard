{ config, lib, pkgs, ... }:
let cfg = config.services.windowManager.river; in
{
  options.services.windowManager.river = {
    enable = lib.mkEnableOption "River - A Wayland Window Manager";
    extraPackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = with pkgs; [ swaylock swaybg swayidle dmenu fuzzel waybar foot ];
    };
  };

  config = lib.mkIf cfg.enable ({
    programs.river = {
      enable = true;
      xwayland.enable = true;
      extraPackages = cfg.extraPackages;
    };
  });
} 
