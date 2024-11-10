{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.system.locale;
in
{
    options.${namespace}.system.locale = with types; {
        enable = mkBoolOpt false "Whether or not to manage locale.";
        locale = mkOpt str "en_US.UTF-8" "Define your locale.";
        extraLocale = mkOpt str "fr_FR.UTF-8" "Define different locale for extra locale settings";
    };

    config = mkIf cfg.enable {
        i18n.defaultLocale = cfg.locale;

        i18n.extraLocaleSettings = {
            LC_ADDRESS = cfg.extraLocale;
            LC_IDENTIFICATION = cfg.extraLocale;
            LC_MEASUREMENT = cfg.extraLocale;
            LC_MONETARY = cfg.extraLocale;
            LC_NAME = cfg.extraLocale;
            LC_NUMERIC = cfg.extraLocale;
            LC_PAPER = cfg.extraLocale;
            LC_TELEPHONE = cfg.extraLocale;
            LC_TIME = cfg.extraLocale;
        };
    };
}
