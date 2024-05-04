{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = with inputs.self.homeManagerModules; [
    home
    common

    #programs.neovim
    #programs.games
    programs.vscode
    #programs.kitty
    programs.alacritty
    programs.direnv

    #services.arrpc
    services.easy-effects
  ];

  home.packages = with pkgs; [
    brave
    kate
    webcord-vencord
    #spotify
    #playerctl
    #obs-studio

    gwenview
    gimp
    # vlc

    #whatsapp-for-linux
    appimage-run
    obsidian
  ];

  wayland.windowManager.hyprland.settings = {
#     monitor = [
#       "eDP-1,preferred,auto,1.5,bitdepth,10"
#     ];
#
#     workspace = [
#       "eDP-1,1"
#     ];

    input = {
    sensitivity = lib.mkForce 0.5;
    accel_profile = "adaptive";
    };
  };
}
