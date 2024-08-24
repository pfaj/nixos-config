{
  config,
  username,
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) self;
in {
  imports = [
    inputs.hyprland.nixosModules.default
    self.nixosModules.sddm
  ];

  # imports hyprland home-manager module
  home-manager.users.${username}.imports = [
    self.homeManagerModules.desktops.hyprland
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
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

  security.polkit.enable = true;

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
  ];

  # greeter
  #  services.greetd = {
  #    enable = true;
  #    settings.default_session.command = pkgs.writeShellScript "greeter" ''
  #      export XKB_DEFAULT_LAYOUT=${config.services.xserver.xkb.layout}
  #      #export XCURSOR_THEME=
  #      ${inputs.aylur-dotfiles.packages.${pkgs.system}.default}/bin/greeter
  #    '';
  #  };
  #
  #  systemd.tmpfiles.rules = [
  #    "d '/var/cache/greeter' - greeter greeter - -"
  #  ];
  #
  #  system.activationScripts.wallpaper = ''
  #    PATH=$PATH:${pkgs.coreutils}/bin:${pkgs.gawk}/bin:${pkgs.jq}/bin
  #    CACHE="/var/cache/greeter"
  #    OPTS="$CACHE/options.json"
  #
  #    cp /home/${username}/.cache/ags/options.json $OPTS
  #    chown greeter:greeter $OPTS
  #
  #    BG=$(cat $OPTS | jq -r '.wallpaper // "/home/${username}/.config/nixos/assets/wallpaper.jpg"')
  #
  #    cp $BG $CACHE/background
  #    chown greeter:greeter $CACHE/background
  #  '';

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
  };
}
