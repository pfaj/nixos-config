{ config, inputs, pkgs, ... }:
{
    imports = with inputs.self.homeManagerModules; [
        home

        #theme.gtk
        #theme.qt

        #programs.dev
        #programs.games
        #programs.vscode
        programs.alacritty
        programs.neovim

        #services.arrpc
        #services.easy-effects

        #desktops.hyprland
        desktops.kde
        #desktops.gnome
    ];

    home.packages = with pkgs; [
        brave
        kate
        webcord-vencord
        #         spotify
#         playerctl
        #         obs-studio

        gwenview
        gimp
#         vlc

        #         whatsapp-for-linux
        appimage-run
        obsidian
    ];
}
