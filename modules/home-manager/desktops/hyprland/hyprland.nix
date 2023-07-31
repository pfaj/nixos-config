{ inputs, pkgs, config, lib, self, ... }:
{
    imports = [
        #inputs.hyprland.homeManagerModules.default
        ./anyrun.nix # runner
        ./mako.nix # notification daemon
    ] ++ (with inputs.self.homeManagerModules; [
        xdg
    ]);

    home.packages = with pkgs; [
        swww
        networkmanagerapplet
        dolphin
        qt5ct
        qt6ct
        ark
        xfce.thunar
        gvfs # might not need for thumbnails?
        gnome.gnome-system-monitor

        swayidle
        swaylock
        wlogout
        wl-clipboard
        wlr-randr

        inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

        eww-wayland
        hyprland-workspaces
    ];

#     xdg.desktopPortals = {
#         enable = true;
#         portals = let useIn = [ "Hyprland" ];
#         in [
#             { package = pkgs.xdg-desktop-portal-hyprland; }
#             {
#                 package = pkgs.libsForQt5.xdg-desktop-portal-kde;
#                 interfaces = [
#                 # "org.freedesktop.impl.portal.Access"
#                 # "org.freedesktop.impl.portal.Account"
#                 # "org.freedesktop.impl.portal.AppChooser"
#                 # "org.freedesktop.impl.portal.Background"
#                 # "org.freedesktop.impl.portal.Email"
#                 "org.freedesktop.impl.portal.FileChooser"
#                 # "org.freedesktop.impl.portal.Inhibit"
#                 # "org.freedesktop.impl.portal.Notification"
#                 # "org.freedesktop.impl.portal.Print"
#                 # "org.freedesktop.impl.portal.ScreenCast"
#                 # "org.freedesktop.impl.portal.Screenshot"
#                 # "org.freedesktop.impl.portal.RemoteDesktop"
#                 # "org.freedesktop.impl.portal.Settings"
#                 ];
#                 inherit useIn;
#             }
#         ];
#     };
}
