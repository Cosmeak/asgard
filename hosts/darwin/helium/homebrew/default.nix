{
  # Homebrew - Using for gui app because majority macos apps does not exists in nixpkgs repository
  imports = [
    ./brews.nix
    ./casks.nix
    ./masapps.nix
  ];

  homebrew.enable = true;
  homebrew.onActivation = {
    autoUpdate = true;
    cleanup = "zap"; # uninstall all elements not listed
  };

  # Repository authorized for homebrew
  homebrew.taps = [
    "homebrew/cask-versions"
    "homebrew/cask-fonts"
    "FelixKratz/formulae"
    "mczachurski/wallpapper"
  ];
}
