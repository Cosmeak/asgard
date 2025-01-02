{ config, lib, pkgs, ... }:
let cfg = config.asgard.programs.windowManager.dwl; in
{
  options.asgard.programs.windowManager.dwl = {
    enable = lib.mkEnableOption "DWL Window Manager";

    xwayland.enable = lib.mkEnableOption "XWayland" // {
      default = true;
    };

    # Move dwl overlay here to give access to override patches
    # packages = lib.mkPackageOption pkgs "dwl" {

    # };

    extraPackages = lib.mkOptions {
      type = with lib.types; listOf package;
      default = with pkgs; [ wmenu foot ];
    };
  };

  config = lib.mkIf cfg.enable ({
    environment.systemPackages = [ pkgs.dwm ] ++ cfg.extraPackages;
    security.polkit.enable = true;
    programs.xwayland.enable = cfg.xwayland.enable;

    # TODO: import and merge wayland-session.nix from nixpkgs nixos modules
    # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/wayland/wayland-session.nix
  });
}
