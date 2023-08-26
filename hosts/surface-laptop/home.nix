{ config, inputs, pkgs, ... }:
{
    imports = with inputs.self.homeManagerModules; [
        home
        #dev

        #theme.gtk
        #theme.qt

        #applications.audio
        #applications.games
        applications.vscode
        applications.kitty

        services.syncthing

        #desktops.hyprland
        desktops.kde
        #desktops.gnome
    ];

    home.packages = with pkgs; [
        brave
        kate
        webcord-vencord
        spotify
        playerctl
        obs-studio

        gwenview
        gimp
        vlc

        whatsapp-for-linux
        appimage-run
        obsidian
    ];
}
