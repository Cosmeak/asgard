{ config, ...} : 
{
    # Enable OpenGL
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = { 
        package = config.boot.kernelPackages.nvidiaPackages.production; # 550 Driver
        modesetting.enable = true;
        powerManagement.enable = false;  
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = true;
    };
}