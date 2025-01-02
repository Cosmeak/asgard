{ lib, pkgs, config, ... }:
let
  cfg = config.asgard.programs.windowManager.amethyst;
in
{
  options.asgard.programs.windowManager.amethyst = {
    enable = lib.mkEnableOption "Amethyst - Aqua (MacOS) Window Manager";
  };

  config = lib.mkIf cfg.enable ({
    homebrew.casks = [ "amethyst" ];
  });
}
