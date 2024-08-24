{pkgs, ...}: {
  home = {
    pointerCursor = {
      name = "McMojave-cursors";
      package = pkgs.mcmojave-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    #sessionVariables = {
    #  #HYPRCURSOR_THEME = "hypr_apple_cursor";
    #  #HYPRCURSOR_THEME = "McMojave-cursors";
    #  HYPRCURSOR_THEME = "HyprBibataModernClassicSVG";
    #  HYPRCURSOR_SIZE = "24";
    #};
  };
}
