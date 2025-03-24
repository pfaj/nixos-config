{
  username,
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) self;
in {
  imports = [
    #inputs.niri-flake.nixosModules.niri
    self.nixosModules.sddm
  ];

  # imports hyprland home-manager module
  home-manager.users.${username}.imports = [
    self.homeManagerModules.desktops.niri
  ];

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
    #power-profiles-daemon.enable = true;
    accounts-daemon.enable = true;

    gnome = {
      evolution-data-server.enable = true;
      glib-networking.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    libappindicator
    kdePackages.kstatusnotifieritem
    gparted
    xwayland-satellite
  ];

  programs.niri.enable = true;
}
