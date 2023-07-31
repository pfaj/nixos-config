{ pkgs, ...}: {
    home.sessionPath = [ "$HOME/.local/bin" ];

    programs.home-manager.enable = true;
}
