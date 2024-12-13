{
  # Homebrew - Using for gui app because majority macos apps does not exists in nixpkgs repository
  
  imports = [
    ./brews.nix
    ./casks.nix
    ./masapps.nix
    ./taps.nix
  ];

  homebrew.enable = true;
  homebrew.onActivation = {
    autoUpdate = true;
    cleanup = "zap"; # uninstall all elements not listed
  };
}