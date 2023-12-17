{ username, ... }:
{
  home = {
    inherit username; 
    homeDirectory = "/home/${username}";
    sessionPath = [ "$HOME/.local/bin" ];
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
