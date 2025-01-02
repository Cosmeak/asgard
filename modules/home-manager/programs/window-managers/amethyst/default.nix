{ lib, pkgs, config, ... }:
let
  cfg = config.asgard.programs.windowManager.amethyst;
  yamlFormat = pkgs.formats.yaml { };
in
{
  options.asgard.programs.windowManager.amethyst = {
    settings = lib.mkOption {
      type = yamlFormat.type;
      default = {
        layouts = [
          "tall"
          "wide"
          "column"
        ];

        window-margins = true;
        window-margin-size = 16;
        window-max-count = 3;

        hide-menu-bar-icon = true;

        mod1 = [
          "command"
          "shift"
        ];

        mod2 = [
          "command"
          "shift"
          "option"
        ];
      };
      description = ''
        Configuration written to {file}`$XDG_CONFIG_HOME/amethyst/amethyst.yml`.
      ''
    };
  };

  config = lib.mkIf (cfg.settings != {}) ({
    home.file."amethyst/amethyst.yml" = {
      source = yamlFormat.generate "amethyst.yml" cfg.settings;
    };
  });
}
