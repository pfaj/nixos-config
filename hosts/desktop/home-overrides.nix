{ config, lib, ... }:
{
    home = {
        file.".local/share/user-places.xbel".source = ./user-places.xbel; # respect custom places dir in filemanagers

        sessionVariables = {
            LIBVA_DRIVER_NAME = "nvidia";
            WLR_NO_HARDWARE_CURSORS = "1";
            WLR_DRM_NO_ATOMIC = "1";
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
            __GL_GSYNC_ALLOWED = "1";
            __GL_VRR_ALLOWED = "1";
            __GL_SYNC_TO_VBLANK = "0";
        };
    };

    xdg.userDirs = {
        enable = true;

        desktop = "/mnt/LinuxExpansion/Places/Desktop";
        documents = "/mnt/LinuxExpansion/Places/Documents";
        download = "/mnt/LinuxExpansion/Places/Downloads";
        music = "/mnt/LinuxExpansion/Places/Audio";
        pictures = "/mnt/LinuxExpansion/Places/Images";
        videos = "/mnt/LinuxExpansion/Places/Videos";

        extraConfig = {
            XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
        };
    };

    gtk.gtk3.bookmarks = [
        "file://${config.xdg.userDirs.desktop}"
        "file://${config.xdg.userDirs.documents}"
        "file://${config.xdg.userDirs.download}"
        "file://${config.xdg.userDirs.music}"
        "file://${config.xdg.userDirs.pictures}"
        "file://${config.xdg.userDirs.videos}"
    ];
}
