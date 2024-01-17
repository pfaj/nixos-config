{pkgs, ...}: {
  home.packages = with pkgs; [
    pavucontrol
    lsp-plugins
    calf
    rnnoise
    zam-plugins
    zita-convolver
    soundtouch

    helvum
  ];

  services.easyeffects.enable = true;
}
