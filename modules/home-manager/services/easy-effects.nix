{pkgs, ...}: {
  home.packages = with pkgs; [
    #lsp-plugins
    #calf
    #rnnoise
    #zam-plugins
    #zita-convolver
    #soundtouch
  ];

  services.easyeffects.enable = true;
}
