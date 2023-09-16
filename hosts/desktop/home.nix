{ inputs, config, pkgs, ... }:
{
    imports = [
        ./home-overrides.nix
    ] ++ (with inputs.self.homeManagerModules; [
        home

        theme.gtk
        theme.qt

        programs.dev
        programs.games
        programs.vscode
        programs.kitty

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
}
