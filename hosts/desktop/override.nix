{ config, lib, ... }:
{
    config = lib.mkIf config.programs.hyprland.enable {
        programs.hyprland.nvidiaPatches = true;
        environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
    };
}
