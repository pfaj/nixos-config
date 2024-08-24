{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    sddm-chili
    libsForQt5.qt5.qtgraphicaleffects
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-chili";
  };
}
