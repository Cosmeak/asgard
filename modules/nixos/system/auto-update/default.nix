{ config, pkgs, lib, ... }:
let
  cfg = config.gems.system.autoUpdate;
in
{
  options.gems.system.autoUpdate = {
    enable = lib.mkEnableOption "Enable system auto update.";
  };

  config = lib.mkIf cfg.enable ({
    system.autoUpgrade = {
      enable = true;
      flake = "/etc/nixos\\?submodules=1";
      flags = [
        "--update-input"
        "nixpkgs"
        "-L"
      ];
      dates = "Sat *-*-* 06:00:00";
      randomizedDelaySec = "45min";
      allowReboot = true;
    };
  });
}
