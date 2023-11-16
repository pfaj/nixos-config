{ inputs, config, pkgs, ... }:
{
    imports = [
        ./home-overrides.nix
    ] ++ (with inputs.self.homeManagerModules; [
        home
        common

        theme.gtk
        theme.qt

        programs.neovim
        programs.dev
        programs.games
        programs.vscode
#         programs.kitty
        programs.alacritty

        services.arrpc
        services.easy-effects

        desktops.hyprland
#         desktops.kde
#         desktops.gnome
    ]);

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
