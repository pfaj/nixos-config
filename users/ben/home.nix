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

        gwenview
        gimp
        vlc
        whatsapp-for-linux

        appimage-run

        obsidian
    ];

    programs = {
        obs-studio.enable = true;
        kitty = {
            enable = true;
            shellIntegration.enableFishIntegration = true;
            settings = {
                scrollback_lines = 10000;
                enable_audio_bell = false;
                update_check_interval = 0;
                window_padding_width = 4;
            };
            extraConfig = ''
                background_opacity 0.85
                background_blur 0
            '';
        };
    };
}
