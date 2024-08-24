{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-cosmic.nixosModules.default
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-cosmic];
    config.common.default = "*";
  };

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.systemPackages = with pkgs; [
    inputs.quickshell.packages.${pkgs.system}.default
    wl-clipboard
    swww # wallpaper
  ];

  #environment.systemPackages = with pkgs; [
  #  cosmic-bg
  #  cosmic-osd
  #  cosmic-term
  #  cosmic-edit
  #  cosmic-comp
  #  cosmic-randr
  #  cosmic-panel
  #  cosmic-icons
  #  cosmic-files
  #  cosmic-greeter
  #  cosmic-applets
  #  cosmic-settings
  #  cosmic-launcher
  #  cosmic-screenshot
  #  cosmic-applibrary
  #  cosmic-design-demo
  #  cosmic-notifications
  #  cosmic-settings-daemon
  #  cosmic-workspaces-epoch
  #];
}
