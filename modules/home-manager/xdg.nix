# XDG stands for "Cross-Desktop Group", with X used to mean "cross".
# It's a bunch of specifications from freedesktop.org intended to standardize desktops and
# other GUI applications on various systems (primarily Unix-like) to be interoperable:
#   https://www.freedesktop.org/wiki/Specifications/
{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        xdg-utils # provides cli tools such as `xdg-mime` `xdg-open`
        xdg-user-dirs
    ];

#     xdg = {
#         enable = true;
#
#         cacheHome = config.home.homeDirectory + "/.local/cache";
#
#         # manage $XDG_CONFIG_HOME/mimeapps.list
#         # xdg search all desktop entries from $XDG_DATA_DIRS, check it by command:
#         #  echo $XDG_DATA_DIRS
#         # the system-level desktop entries can be list by command:
#         #   ls -l /run/current-system/sw/share/applications/
#         # the user-level desktop entries can be list by command(user ben):
#         #  ls /etc/profiles/per-user/ben/share/applications/
#         userDirs = {
#             enable = true;
#
#             desktop = "/mnt/LinuxExpansion/Places/Desktop";
#             documents = "/mnt/LinuxExpansion/Places/Documents";
#             download = "/mnt/LinuxExpansion/Places/Downloads";
#             music = "/mnt/LinuxExpansion/Places/Audio";
#             pictures = "/mnt/LinuxExpansion/Places/Images";
#             videos = "/mnt/LinuxExpansion/Places/Videos";
#
#             extraConfig = {
#                 XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
#             };
#         };
#     };
}
