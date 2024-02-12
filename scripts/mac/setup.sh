#!/bin/zsh

# Install XCode cli tools
echo "Installing command line tools..."
xcode-select --install

# Homebrew
## Installing
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## Tapping
echo "Tapping Brew..."
brew tap homebrew/cask-fonts
brew tap FelixKratz/formulae

## Formulae
echo "Installing Brew Formulae"
### Terminal
brew install neovim
brew install starship
brew install zsh-autosuggestions
brew install zsh-syntax-hightlighting

### Utils
brew install btop

## Cask
echo "Installing Brew Cask"
brew install --cash kitty # terminal
brew install --cask spotify
brew install --cask discord
brew install --cask brave-browser
brew install --cask amethyst # Window Manager
brew install --cask aldente # Battery Manager - For Macbook

### Fonts
brew install --cask sf-symbols
brew install --cask font-fira-code
brew install --cask font-hack-nerd-font
brew install --cask homebrew/cask-fonts/font-jetbrains-mono-nerd-font

# Copying and checking configuration files
echo "Download and checkout configuration files"
[ ! -d "$HOME/dotfile"] && git clone --bare --branch macos --single-branch git@github.com:Cosmeak/dotfiles.git
git --git-dir=$HOME/dotfile/ --work-tree=$HOME/.config/ checkout macos

# Start services
echo "Starting services..."
brew services start sketchybar

# End
echo "Installing Complete."
