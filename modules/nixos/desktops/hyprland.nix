{
  username,
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) self;
in {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  # imports hyprland home-manager module
  home-manager.users.${username}.imports = [
    self.homeManagerModules.desktops.hyprland
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs.gnome; [
    pkgs.gnome-icon-theme
    adwaita-icon-theme
    nautilus
    gnome-calendar
    gnome-control-center
    gnome-weather
    gnome-calculator
    gnome-clocks
    gnome-software
    gnome-system-monitor

    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    #config.common.default = "*";
    config = {
      common = {
        default = [
          "*"
        ];
      };
    };
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  services = {
    blueman.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    upower.enable = true;
    accounts-daemon.enable = true;
    gnome = {
      evolution-data-server.enable = true;
      glib-networking.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    #package = null;
  };
}
