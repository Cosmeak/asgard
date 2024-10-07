{
  description = "Nix config for MacOS";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";

    darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows= "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, darwin, home-manager, ... }:
  let
    system = "aarch64-darwin";
    hostname = "njord";

    specialArgs = inputs // { inherit hostname; };

    configuration = { pkgs, ... }: { nixpkgs.config = {
        allowUnfree = true;
        allowInsecure = false;
        allowBroken = true;
        allowUnsupportedSystem = true;
      };
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
            # Dev
            pkgs.neovim
            pkgs.kitty
            pkgs.vscode

            pkgs.php
            pkgs.phpPackages.composer
            pkgs.nodejs

            # CLI
            pkgs.starship
            pkgs.zoxide
            pkgs.tree
            pkgs.btop
            pkgs.lazygit
            pkgs.ngrok
            pkgs.fastfetch

            # Apps
            pkgs.spicetify-cli

            # Utilities
            pkgs.alt-tab-macos
            pkgs.raycast
        ]; # Auto upgrade nix package and the daemon service. services.nix-daemon.enable = true; # nix.package = pkgs.nix;
      # Create /etc/zshrc that loads the darwin environment.
      programs.zsh = {
      	enable = true;
        enableBashCompletion = true;
        enableCompletion = true;
        enableSyntaxHighlighting = true;
        loginShellInit = ''
        	eval "$(zoxide init zsh)"
            eval "$(/opt/homebrew/bin/brew shellenv)"
            alias switch="darwin-rebuild switch --flake ~/.config/nix-darwin"
        '';
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

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

      # Apps from App Store@
      homebrew.masApps = {
        # Xcode = 497799835;
        Slack = 803453959;
      };
    };
  in
  {
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [ configuration ];
    };

    # Nix code formatter
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."${hostname}".pkgs;
  };
}

# Rebuild system with
# darwin-rebuild switch --flake .
# Relaunch dock
# killall Dock
