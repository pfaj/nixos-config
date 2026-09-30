{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sddm-chili
    qt5.qtgraphicaleffects
    # libsForQt5.qt5.qtgraphicaleffects
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-chili";
  };
}
