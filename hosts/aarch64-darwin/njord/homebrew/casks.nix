{
  homebrew.casks = [
    # Dev
    "zed"
    "vscodium" # used for jupyter notebook because not available in zed at this time
    "beekeeper-studio" # find a better alternative
    "insomnia"
    "orbstack" # replace with simple docker desktop
    "figma"
    "dbngin" # will be removed when all my project will used flakes and docker for databases
    "arduino-ide"

    # Apps
    "spotify"
    "discord"
    "thunderbird" # install via nix if possiblex
    "obsidian"
    "brave-browser"
    "zen-browser"
    "1password"

    # Mics
    "amethyst" # Window manager
    "stats" # System monitoring displayed in macos top bar - will be replaced by custom script with sketchybar

    # Fonts
    "sf-symbols"
    "font-hack-nerd-font" # move this to nix installation
  ];
}
