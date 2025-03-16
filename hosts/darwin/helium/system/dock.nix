{
  system.defaults.dock = {
    autohide = true;
    orientation = "bottom"; # Set dock to bottom
    mru-spaces = false; # Auto arrange space based on the most recent use
    launchanim = false; # Remove animation when opening an app
    mineffect = "scale"; # Change animation from minimize/maximize app
    magnification = false;
    minimize-to-application = true; # Minimize app in app icon
    show-recents = false; # Don't show recent open apps
    tilesize = 32; # Set dock size

    # Set dock apps (remove all apps from dock)
    persistent-apps = [];

    # Disable hot corners
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
  };
}
