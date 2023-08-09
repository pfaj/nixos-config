{ config, ... }:
{
    hardware.nvidia = {
        modesetting.enable = true; # fix wayland
        package = config.boot.kernelPackages.nvidiaPackages.beta; # idek if this works
    };
}
