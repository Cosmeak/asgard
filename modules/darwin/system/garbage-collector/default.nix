{ config, pkgs, lib, ... }:
let
  cfg = config.gems.system.garbageCollector;
in
{
  options.gems.system.garbageCollector = {
    enable = lib.mkEnableOption "Enable garbage collection.";
  };

  config = lib.mkIf cfg.enable ({
    # Perform garbage collection weekly to maintain low disk usage
    nix.gc = {
      automatic = true;
      interval = [{ Weekday = 7; }];
      options = "--delete-older-than 7d";
    };
    nix.optimise.automatic = true;
  });
}
