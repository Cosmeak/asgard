{ lib, pkgs, inputs, namespace, system, target, format, virtual, systems, config, ... }:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.desktop.amethyst;
in
{
    options.${namespace}.desktop.amethyst = with types; {
        enable = mkBoolOpt false "Wheter or not to enable Amethyst WM.";
    };

    config = mkIf cfg.enable {
        homebrew.casks = [ "amethyst" ];
    };
}
