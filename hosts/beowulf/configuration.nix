{ config, lib, pkgs, microvm, ...}:
{
    networking.hostName = "beowulf";

    microvm.vms = {
        forgejo = {
            services.forgejo.enable = true;
        };
    };
}
