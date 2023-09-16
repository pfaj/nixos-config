{ inputs, pkgs, ... }: {
    imports = [
        inputs.hyprland.nixosModules.default
    ];

    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        QT_STYLE_OVERRIDE = "kvantum";
    };

    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    security = {
        polkit.enable = true;
    };

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
        };
    };

    services = {
        blueman.enable = true;
        gvfs.enable = true;
        udisks2.enable = true;
        upower.enable = true;
        gnome.gnome-keyring.enable = true;
    };

    programs = {
        dconf.enable = true;

        hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        };
    };
}
