{ config, inputs, pkgs, ... }:
{
    imports = with inputs.self.homeManagerModules; [
        home
        dev
        theme.gtk
        theme.qt
        desktops.hyprland
        applications.audio
        applications.games
        applications.vscode
        applications.kitty
        services.syncthing
    ];

    home = {
        username = "ben";
        homeDirectory = "/home/ben";
        stateVersion = "23.05";
    };

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
