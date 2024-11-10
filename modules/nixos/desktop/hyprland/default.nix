{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.desktop.hyprland;
in
{
    options.${namespace}.desktop.hyprland = with types; {
        enable = mkBoolOpt false "Whether or not to enable Hyprland WM.";
    };

    config = mkIf cfg.enable {
        # TODO: Enable a basic hyprland configuration with plugins and basic app for a desktop experience
    };
}
