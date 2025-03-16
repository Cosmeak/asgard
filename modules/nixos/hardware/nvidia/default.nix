{ config, pkgs, lib, ... }:
let
  cfg = config.gems.hardware.nvidia;
in
{
  options.gems.hardware.nvidia = {
    enable = lib.mkEnableOption "Enable an opiniated configuration for NVIDIA gpus.";
    withOpenGL = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Choose to disable Open GL.";
    };
    # package = lib.mkOption {
    #   type = with lib.types.package;
    #   default = config.boot.kernelPackages.nvidiaPackages.latest;
    #   description = "Choose a different version of NVIDIA drivers.";
    # };
  };

  config = lib.mkIf cfg.enable ({
    hardware.graphics = {
      enable = cfg.withOpenGL;
      enable32Bit = cfg.withOpenGL;
    };
    services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };
  });
}
