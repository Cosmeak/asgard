# MacOS

All configuration files for my mac environment.

Used for software and web development.

## Sketchybar Setup

Repository: https://github.com/FelixKratz/SketchyBar

```bash
# Tapping brew
brew tap homebrew/cask-font
brew tap FelixKratz/SketchyBar

# Installing brew formulae
brew install --cask sf-symbols
brew install --cask font-hack-nerd-font # Default font for SketchyBar
brew install sketchybar

# Authorize plugins
chmod +x ~/.config/sketchybar/plugins/battery.sh
chmod +x ~/.config/sketchybar/plugins/clock.sh
chmod +x ~/.config/sketchybar/plugins/front_app.sh
chmod +x ~/.config/sketchybar/plugins/space.sh
chmod +x ~/.config/sketchybar/plugins/volume.sh
```

Replace content of `~/.config/sketchybar/sketchybarrc` by [my configuration](./sketchybar/sketchybarrc).

And your done with it.

## Additionnal usage

### [wallpaper](https://github.com/mczachurski/wallpapper)
  
Used to make custom wallpaper for light and dark theme
