{
  self,
  username,
  inputs,
  pkgs,
  ...
}: let
  hugchat = ps:
    ps.buildPythonPackage rec {
      pname = "hugchat";
      version = "0.4.1";
      src = ps.fetchPypi {
        inherit pname version;
        sha256 = "260141e66fd0bd2dcd46b21f5d3dbc15cd4bc1ff5ed85550f65c2fc31d1bd7eb";
      };
      doCheck = false;
    };
in {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    #inputs.aylur-dotfiles.packages.${pkgs.system}.default

    bun
    dart-sass
    fd
    fzf
    brightnessctl
    swww
    slurp
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
    networkmanager
    matugen
    #(python3.withPackages (ps:
    #  with ps; [
    #    requests
    #    (hugchat ps)
    #  ]))
  ];

  programs.ags = {
    enable = true;
    #configDir = inputs.aylur-dotfiles.packages.${pkgs.system}.config;
    #extraPackages = with pkgs; [
    #  accountsservice
    #];
  };

  #programs.astal = {
  #enable = true;
  #  extraPackages = with pkgs; [
  #    libadwaita
  #  ];
  #};

  #xdg.configFile."ags".source = "${inputs.aylur-dotfiles}/ags";

  #home.file.".cache/ags/options.json".text = ''
  #  {
  #    "hyprland.gapsWhenOnly": true,
  #    "bar.battery.blocks": 7,
  #    "bar.battery.width": 50,
  #    "launcher.apps.favorites": [
  #      [
  #        "brave-browser",
  #        "org.gnome.Nautilus",
  #        "alacritty",
  #        "org.gnome.Calendar"
  #      ],
  #      [
  #        "steam",
  #        "vesktop",
  #        "spotify",
  #        "whatsapp"
  #      ]
  #    ],
  #    "theme.blur": 40,
  #    "bar.date.format": "%I:%M %p - %A %e",
  #    "bar.workspaces.workspaces": 7,
  #    "wallpaper": "/home/${username}/.config/nixos/assets/wallpaper.jpg",
  #    "quicksettings.avatar.image": "/home/${username}/.config/nixos/assets/user-avatar.jpg",
  #    "theme.border.width": 0,
  #    "theme.dark.widget": "#eae0e7",
  #    "theme.light.widget": "#1f1a1f",
  #    "theme.dark.border": "#988e97",
  #    "theme.light.border": "#7d747d",
  #    "theme.dark.bg": "#161217",
  #    "theme.light.bg": "#fff7fb",
  #    "theme.dark.fg": "#eae0e7",
  #    "theme.light.fg": "#1f1a1f",
  #    "theme.dark.primary.bg": "#e5b6f2",
  #    "theme.light.primary.bg": "#775084",
  #    "bar.battery.charging": "#e5b6f2",
  #    "theme.dark.primary.fg": "#452152",
  #    "theme.light.primary.fg": "#ffffff",
  #    "theme.dark.error.bg": "#ffb4ab",
  #    "theme.light.error.bg": "#ba1a1a",
  #    "theme.dark.error.fg": "#690005",
  #    "theme.light.error.fg": "#ffffff"
  #  }
  #'';
}
