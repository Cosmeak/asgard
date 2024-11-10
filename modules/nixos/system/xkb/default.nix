{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.system.xkb;
in
{
    options.${namespace}.system.xkb = with types; {
        enable = mkBoolOpt false "Whether or not to configure xkb.";
        layout = mkOpt str "us" "Define your xbk layout.";
    };

    config = mkIf cfg.enable {
        services.xserver.xkb.layout = cfg.layout;
        # TODO : add alternative variant and layout switcher
    };
}
