{
    #Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable XFCE Desktop Environment
    services.xserver.desktopManager.xterm.enable = false;
    services.xserver.desktopManager.xfce.enable = true;

    services.displayManager.defaultSession = "xfce";
}
