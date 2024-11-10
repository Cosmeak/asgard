{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.system.time;
in
{
    options.${namespace}.system.time = with types; {
        enable = mkBoolOpt false "Whether or not to manage timezone.";
        timezone = mkOpt str "Europe/Paris" "Define your timezone.";
    };

    config = mkIf cfg.enable {
        time.timeZone = cfg.timezone;
    };
}
