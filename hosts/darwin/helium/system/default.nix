{
  imports = [
    ./dock.nix
    ./finder.nix
    ./nsglobaldomain.nix
  ];

  # Disable startup sound
  system.nvram.variables = {
    "StartupMute" = "%01";
  };

  system.defaults = {
    # Deactivate state manager
    WindowManager.GloballyEnabled = false;
    # Text show in the login window
    loginwindow.LoginwindowText = "Maybe you cannot touch me";
  };
}
