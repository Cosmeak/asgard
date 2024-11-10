{ options, config, lib, pkgs, namespace, ... } :
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.apps.steam;
in
{
    options.${namespace}.apps.steam = with types; {
        enable = mkBoolOpt false "Whether or not to enable support for Steam.";
    };

    config = mkIf cfg.enable {
        programs.steam = {
            enable = true;
            gamescopeSession.enable = true;
        };

        programs.gamemode.enable = true;

        environment.sessionVariables = {
            STEAM_EXTRA_COMPAT_TOOS_PATHS = "/home/cosmeak/.steam/root/compatibilitytools.d";
        };
    };
}
