{ config, lib, ... }:
{
    config = lib.mkIf config.programs.hyprland.enable {
        programs.hyprland.enableNvidiaPatches = true;
        environment.sessionVariables = {
            LIBVA_DRIVER_NAME = "nvidia";
            WLR_NO_HARDWARE_CURSORS = "1";
            WLR_DRM_NO_ATOMIC = "1";
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
            __GLX_GSYNC_ALLOWED = "1";
            __GL_VRR_ALLOWED = "1";
        };
    };
}
