{pkgs, ...}: {
  home.packages = with pkgs; [macchina];

  xdg.configFile."macchina/themes/custom.toml" = {
    text = ''
      spacing         = 3
      hide_ascii      = true
      key_color       = "#7067CF"
      separator       = ""

      [box]
      border          = "plain"
      visible         = true

      [palette]
      type            = "Light"
      glyph           = "●  "
      visible         = true

      [box.inner_margin]
      x               = 2
      y               = 1

      [custom_ascii]
      color           = "#FF7001"
    '';
  };
}
