{
  inputs,
  pkgs,
  username,
  ...
}: let
  inherit (inputs) self;
in {
  # imports wayfire home-manager module
  home-manager.users.${username}.imports = [
    self.homeManagerModules.desktops.wayfire
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  security.polkit.enable = true;

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
    gnome.gnome-keyring.enable = true;
  };

  programs = {
    dconf.enable = true;
    wayfire = {
      enable = true;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];
    };
  };
}
