{
    #Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable Budgie Desktop Environment
    services.xserver.desktopManager.budgie.enable = true;
    services.xserver.displayManager.lightdm.enable = true;
}