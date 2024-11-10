{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.hardware.networking;
in
{
    options.${namespace}.hardware.networking = with types; {
        enable = mkBoolOpt false "Whether or not to enable networking.";
    };

    config = mkIf cfg.enable {
        networking.networkmanager.enable = true;
    };
}
