{ inputs, pkgs, ...}:
{
  users.users."ben" = {
    isNormalUser = ben;
    description = "cosmeak";
    extraGroups = [ "wheel" ];

    # User wide packages
    packages = with pkgs; [
      # Add packages here
    ];
  };
}
