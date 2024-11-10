{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.hardware.audio;
in
{
    options.${namespace}.hardware.audio = with types; {
        enable = mkBoolOpt false "Whether or not to enable audio support.";
    };

    config = mkIf cfg.enable {
        # Enable sound with pipewire.
        hardware.pulseaudio.enable = false;
        security.rtkit.enable = true;
        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };
    };
}
