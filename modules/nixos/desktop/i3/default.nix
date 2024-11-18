{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.${namespace};
let
    cfg = config.${namespace}.desktop.i3;
in
{
    options.${namespace}.desktop.i3 = with types; {
        enable = mkBoolOpt false "Wheter or not to enable i3 Window Manager 'Suite'.";
    };

    config = mkIf cfg.enable {
        services.xserver = {
            enable = true;

            desktopManager = {
                xterm.enable = false;
            };

            windowManager.i3 = {
                enable = true;
                extraPackages = with pkgs; [
                    dmenu
                    i3status
                    i3lock
                    # i3blocks
                ];
            };
        };

        services.displayManager = {
            defaultSession = "none+i3";
        };

        asgard.home.extraOptions.xsession.windowManager.i3 = {
            enable = true;
            config = {
                terminal = "kitty";
                gaps = {
                    inner = 16;
                    outer = 16;
                };
                window.commands = [
                    {
                        command = "floating enable";
                        criteria = {
                            class = "steam";
                        };
                    }
                ];
            };
        };
    };
}
