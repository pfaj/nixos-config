{
  inputs,
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
}
