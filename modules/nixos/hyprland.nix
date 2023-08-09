{ inputs, pkgs, ... }: {
    imports = [
        inputs.hyprland.nixosModules.default
    ];

    xdg = {
        mime = {
            enable = true;
            defaultApplications =
        let
            browser = [ "brave-browser.desktop" ];
            files = [ "org.kde.dolphin.desktop" ];
        in
            {
                "application/json" = browser;
                "application/pdf" = browser;
                "application/octet-stream" = files;
                "inode/directory" = files;

                "text/html" = browser;
                "text/xml" = browser;
                "application/xml" = browser;
                "application/xhtml+xml" = browser;
                "application/xhtml_xml" = browser;
                "application/rdf+xml" = browser;
                "application/rss+xml" = browser;
                "application/x-extension-htm" = browser;
                "application/x-extension-html" = browser;
                "application/x-extension-shtml" = browser;
                "application/x-extension-xht" = browser;
                "application/x-extension-xhtml" = browser;

                "x-scheme-handler/discord" = [ "webcord.desktop" ];

                "audio/*" = [ "vlc.desktop" ];
                "video/*" = [ "vlc.dekstop" ];
                "image/*" = [ "gwenview.desktop" ];
            };
        };

        portal = {
#             extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        };
    };

    services = {
        udisks2.enable = true;
        gnome.gnome-keyring.enable = true;
        xserver.gdk-pixbuf.modulePackages = [ pkgs.librsvg ]; # for eww icons to work
    };

    programs = {
        hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        };
    };
}
