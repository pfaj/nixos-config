{ pkgs, ...}: {
    home = {
        username = "ben";
        homeDirectory = "/home/ben";
        sessionPath = [ "$HOME/.local/bin" ];
        stateVersion = "23.05";
    };

    programs.home-manager.enable = true;
}
