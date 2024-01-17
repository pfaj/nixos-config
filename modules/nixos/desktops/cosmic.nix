{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-cosmic];
    config.common.default = "*";
  };

  environment.systemPackages = with pkgs; [
    cosmic-bg
    cosmic-osd
    cosmic-term
    cosmic-edit
    cosmic-comp
    cosmic-randr
    cosmic-panel
    cosmic-icons
    cosmic-files
    cosmic-greeter
    cosmic-applets
    cosmic-settings
    cosmic-launcher
    cosmic-screenshot
    cosmic-applibrary
    cosmic-design-demo
    cosmic-notifications
    cosmic-settings-daemon
    cosmic-workspaces-epoch
  ];
}
