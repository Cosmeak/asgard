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

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''${pkgs.greetd.tuigreet}/bin/tuigreet \
            --remember \
            --remember-session \
            --asterisks \
            --time '';
        user = "greeter";
        };
      };
    };

    environment.etc."greetd/environments".text = ''
      river
    '';
  });
} 
