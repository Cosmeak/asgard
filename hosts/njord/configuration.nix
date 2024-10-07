{ self, inputs, outputs, pkgs, ... }:
{
    # imports = [
    #     ./../../modules/darwin/gc.nix
    # ];

    # Nixpkgs config
    nixpkgs.config = {
        allowUnfree = true;
        allowUnsecure = false;
        allowBroken = true;
        allowUnsupportedSystem = true;
    };
    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";

    # Use nix as a daemon
    services.nix-daemon.enable = true;

    # Enable sudo via TouchID
    security.pam.enableSudoTouchIdAuth = true;

    # Config Macos with preference
    # Disable startup sound
    system.nvram.variables = {
        "StartupMute" = "%01";
    };
    system.defaults = {
    	# Dock
        dock = {
       	autohide = true;
           	orientation = "bottom"; # Set dock to bottom
           	mru-spaces = false; # Auto arrange space based on the most recent use
           	launchanim = false; # Remove animation when opening an app
            mineffect = "scale"; # Change animation from minimize/maximize app
            magnification = false;
            minimize-to-application = true; # Minimize app in app icon
            show-recents = false; # Don't show recent open apps
            tilesize = 32; # Set dock size
            # Set dock apps
            persistent-apps = [
   	            "/Applications/Thunderbird.app"
   	            "/Applications/Brave Browser.app"
   	            "/Applications/Discord.app"
                "/Applications/Spotify.app"
                "/Applications/Obsidian.app"
   	            "/Applications/Nix Apps/kitty.app"
   	            "/Applications/Zed.app"
   	            "/Applications/Beekeeper Studio.app"
           	];
        };

     	# Finder
   	    finder = {
			AppleShowAllExtensions = true; # Show file extension
			AppleShowAllFiles = true; # Show hidden files
			FXPreferredViewStyle = "clmv"; # Set default view to column
			CreateDesktop = false; # Disable show icon on desktop
			FXDefaultSearchScope = "SCcf"; # Set default search scope to current folder
    	};

        # Screenshot
        screencapture.location = "~/Pictures/screenshots";

        NSGlobalDomain = {
      		# Switch between dark and light mode automatically
            AppleInterfaceStyleSwitchesAutomatically = true;
      		# Disable saving new documents to icloud
       	    NSDocumentSaveNewDocumentsToCloud = false;
    	};
    };

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs; [
        # Dev environment most used
        php83
        php83Packages.composer
        nodejs_20

        # CLI
        neovim
        starship
        zoxide
        tree
        btop
        lazygit
        ngrok
        fastfetch

        # Utilities
        kitty
        alt-tab-macos
        raycast
    ];

    # Homebrew - Using only for gui app because macos app do not existe un nixpkgs repository
    homebrew.enable = true;
    homebrew.onActivation = {
        autoUpdate = true;
        cleanup = "zap"; # uninstall all elements not listed below
    };
    homebrew.taps = [
        "homebrew/cask-versions"
        "homebrew/cask-fonts"
        "FelixKratz/formulae"
    ];

    homebrew.brews = [
        "cocoapods"
        "yarn"
    ];

    homebrew.casks = [
        # Dev
        "zed"
        "beekeeper-studio"
        "insomnia"
        "orbstack"
        "figma"
        "dbngin"
        "github"
        "mongodb-compass"
        "cyberduck"

        # Apps
        "spotify"
        "discord"
        "thunderbird"
        "obs"
        "obsidian"
        "modrinth"
        "zen-browser"
        "brave-browser"
        "balenaetcher"

        # Utilities
        "amethyst"
        # "sketchybar"
        "stats"
        "logi-options-plus"

        # Fonts
        "sf-symbols"
        "font-hack-nerd-font"
    ];

    # Apps from App Store
    homebrew.masApps = {
        # Xcode = 497799835;
        Slack = 803453959;
    };

    programs.zsh = {
        enable = true;
        enableBashCompletion = true;
        enableCompletion = true;
        enableSyntaxHighlighting = true;
        loginShellInit = ''
            eval "$(zoxide init zsh)"
            eval "$(/opt/homebrew/bin/brew shellenv)"
            alias rebuild="darwin-rebuild switch --flake ~/.dotfiles"
        '';
    };

    # Set Git commit hash for darwin-version.
    system.configurationRevision = outputs.rev or outputs.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 5;
}
