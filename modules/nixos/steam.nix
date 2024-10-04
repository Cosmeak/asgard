{
    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;

    environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOS_PATHS = "/home/cosmeak/.steam/root/compatibilitytools.d";
  };
}