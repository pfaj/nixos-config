{ inputs
, pkgs
, ...
}:
let
  inherit (inputs) self;
in
{
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  # imports hyprland home-manager module
  home-manager.users.ben.imports = [
    self.homeManagerModules.desktops.hyprland
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    #   config.common.default = "*";
    config = {
      common = {
        default = [
          "gtk"
        ];
      };
    };
  };

  security = {
    polkit.enable = true;
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
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

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.default;
    };
  };
}
