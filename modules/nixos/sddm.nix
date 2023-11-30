{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    sddm-chili
    libsForQt5.qt5.qtgraphicaleffects
  ];

  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "sddm-chili";
  };
}
