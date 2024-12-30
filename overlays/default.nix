{ inputs, outputs, ... }:
{
    unstable-packages = import ./unstable { inherit inputs outputs; };
    dwl = import ./dwl { inherit inputs outputs; };
}