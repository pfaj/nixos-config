{pkgs, ...}: {
  home.packages = with pkgs; [hack-font];

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "hack";
          style = "Regular";
        };
      };

      colors = {
        transparent_background_colors = true;

        # Colors (Hyper)
        # Default colors
        primary = {
          background = "#171717";
          foreground = "#eeeeee";
        };

        cursor = {
          text = "#F81CE5";
          cursor = "#eeeeee";
        };

        # Normal colors
        normal = {
          black = "#000000";
          red = "#fe0100";
          green = "#33ff00";
          yellow = "#feff00";
          blue = "#0066ff";
          magenta = "#cc00ff";
          cyan = "#00ffff";
          white = "#d0d0d0";
        };

        # Bright colors
        bright = {
          black = "#808080";
          red = "#fe0100";
          green = "#33ff00";
          yellow = "#feff00";
          blue = "#0066ff";
          magenta = "#cc00ff";
          cyan = "#00ffff";
          white = "#FFFFFF";
        };
      };

      window = {
        opacity = 0.99;
        #dynamic_padding = true;
        padding = {
          x = 4;
          y = 4;
        };
      };
    };
  };
}
