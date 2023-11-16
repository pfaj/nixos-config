{ config, lib, ... }:
{
    config = lib.mkIf config.programs.hyprland.enable {
        programs.hyprland.enableNvidiaPatches = true;
    };
}
