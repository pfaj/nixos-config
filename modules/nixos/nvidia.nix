{ config, ... }:
{
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement = {
            enable = false;
            finegrained = false;
        };

        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    services.xserver.videoDrivers = [ "nvidia" ];
}
