{
  inputs,
  pkgs,
  lib,
  username,
  ...
}: let
  # Not every host has a wallpaper; only link it when present.
  wallpaper = ../../hosts/${username}/wallpaper.jpg;
in {
  imports = with inputs.self.homeManagerModules; [
    home
    shell

    programs.alacritty
    programs.direnv
    programs.neovim
    programs.vesktop
    programs.vscode
    programs.tmux
    programs.quickshell

    # custom web apps
    # programs.bandlab
    # programs.chatgpt
    # programs.reddit
    # programs.messages
    # programs.spotify
    # programs.syncthing
    # programs.youtube
  ];

  home.packages = with pkgs; [
    # custom scripts
    editconf
    rmshit # bypasses homemanager bug
    bkqs

    # brave
    # neovide
  ];

  home.file.".config/background" = lib.mkIf (builtins.pathExists wallpaper) {
    source = wallpaper;
  };
}
