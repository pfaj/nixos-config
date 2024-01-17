{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  xdg.configFile."ags".source = "${inputs.aylur-dotfiles}/ags";

  home = {
    file.".cache/ags/options.json".text = ''
      {
        "theme.name": "Space",
        "theme.icon": "",
        "theme.scheme": "dark",
        "theme.bg": "transparentize(#171717, 0.3)",
        "theme.fg": "#eeeeee",
        "theme.accent.gradient": "to right, $accent, lighten($accent, 6%)",
        "theme.widget.bg": "$fg-color",
        "theme.widget.opacity": 95,
        "border.opacity": 92,
        "border.width": 0,
        "hypr.inactive_border": "rgba(333333ff)",
        "bar.style": "normal",
        "bar.separators": false,
        "desktop.wallpaper.fg": "#fff",
        "desktop.wallpaper.img": "${config.xdg.configHome}/nixos/macos-wallpaper.jpg",
        "desktop.screen_corners": true,
        "desktop.drop_shadow": true,
        "spacing": 8,
        "padding": 8,
        "radii": 16,
        "theme.accent.accent": "$magenta",
        "desktop.clock.enable": false,
        "bar.icon": "",
        "bar.flat_buttons": false,
        "battery.show_percentage": false,
        "font.font": "Roboto 10",
        "font.size": 13,
        "desktop.avatar": "${config.xdg.configHome}/nixos/user-avatar.jpg",
        "workspaces": 10
      }
    '';

    packages = with pkgs; [
      sassc
      swww
      brightnessctl

      hyprpicker
      slurp
      wf-recorder
      wayshot
      imagemagick
      wl-gammactl
      pavucontrol
      swappy
      libnotify
      (python311.withPackages (p: [p.python-pam]))
    ];
  };

  programs.ags = {
    enable = true;
    extraPackages = [pkgs.libsoup_3];
  };
}
