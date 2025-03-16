{ config, pkgs, lib, ... }:
let
  cfg = config.gems.programs.steam;
in
{
  options.gems.programs.steam = {
    enable = lib.mkEnableOption ''
      Enable an opiniated configuration for Steam.
      This is a basic steam configuration at the moment, this will be change in the future for optimization and console like experience.
    '';
  };

  config = lib.mkIf cfg.enable ({
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
   };
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOS_PATHS = "/home/cosmeak/.steam/root/compatibilitytools.d";
    };
  });
}
