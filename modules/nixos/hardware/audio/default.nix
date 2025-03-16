{ config, pkgs, lib, ... }:
let
  cfg = config.gems.hardware.audio;
in
{
  options.gems.hardware.audio = {
    enable = lib.mkEnableOption "Enable opinated audio configuration.";
  };

  config = lib.mkIf cfg.enable ({
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  });
}
