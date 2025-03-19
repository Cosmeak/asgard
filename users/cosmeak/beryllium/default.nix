{ inputs, pkgs, ...}:
{
  imports = [ ../common ];

  users.users."cosmeak" = {
    isNormalUser = true;
    description = "cosmeak";
    extraGroups = [ "wheel" ];

    # User wide packages
    packages = with pkgs; [
      # Add packages here
    ];
  };
}
