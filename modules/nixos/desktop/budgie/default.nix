{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.desktop.budgie;
in
{
    options.${namespace}.desktop.budgie = with types; {
        enable = mkBoolOpt false "Wheter or not to enable Budgie Desktop Environment.";
    };

    config = mkIf cfg.enable {
        services.xserver.enable = true;
        services.xserver.desktopManager.budgie.enable = true;
        services.xserver.displayManager.lightdm.enable = true;
    };
}
