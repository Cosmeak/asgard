{ lib, pkgs, inputs, namespace, system, target, format, virtual, systems, config, ... }:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.desktop.aerospace;
in
{
    options.${namespace}.desktop.aerospace = with types; {
        enable = mkBoolOpt false "Wheter or not to enable aerospace WM.";
    };

    config = mkIf cfg.enable {
        homebrew.casks = [ "nikitabobko/tap/aerospace" ];
        # TODO add skhd, sketchybar and yankyborder
        asgard.home.file.".config/aerospace/aerospace.toml".source = ./i3-like-default.toml;
    };
}
