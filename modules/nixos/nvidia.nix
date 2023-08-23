{ config, ... }:
{
    hardware.nvidia = {
        modesetting.enable = true; # fix wayland
    };
}
