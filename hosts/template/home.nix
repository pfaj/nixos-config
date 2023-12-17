{ inputs
, config
, pkgs
, ...
}:
let
  inherit (inputs) self;
  homeManagerModules = with inputs.self.homeManagerModules; [
    home
    common

    #programs.neovim
    #programs.games
    #programs.vscode
    #programs.kitty
    #programs.alacritty
    #programs.direnv

    #services.arrpc
    #services.easy-effects
  ];
in
{
  imports = homeManagerModules;

  home = {
    file.".local/share/user-places.xbel".source = ./user-places.xbel; # respect custom places dir in file managers
  };
}
