{ lib, pkgs, inputs, namespace, system, target, format, virtual, systems, config, ... }:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.desktop.aerospace;
in
{
    options.${namespace}.desktop.aerospace = with types; {
        enable = mkBoolOpt false "Wheter or not to enable aerospace WM suite.";
    };

    config = mkIf cfg.enable {
        services.aerospace = {
            enable = true;
        };
        # Use i3 like config as default
        asgard.home.file.".config/aerospace/aerospace.toml".source = ./i3-like-default.toml;

        # Enable skhd to overide keyboard inputs and make other layout than qwerty functional
        services.skhd = {
            enable = true;
        };

        # Use jankyboarders to see which window is in focus
        services.jankyborders = {
            enable = true;
        };

        # Use sketcybar to replace default macos bar and have something customizable
        services.sketchybar = {
            enable = true;
        };
    };
}
