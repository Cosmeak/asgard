{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.hardware.gpu.nvidia;
in
{
    options.${namespace}.hardware.gpu.nvidia = with types; {
        enable = mkBoolOpt false "Whether or not to enable support for NVIDIA GPU.";
    };

    config = mkIf cfg.enable {
        # Enable OpenGL
        hardware.graphics = {
            enable = true;
            enable32Bit = true;
        };

        services.xserver.videoDrivers = [ "nvidia" ];
        hardware.nvidia = {
            package = config.boot.kernelPackages.nvidiaPackages.production;
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            open = false;
            nvidiaSettings = true;
        };
    };
}
