{ pkgs, ... }:
{
    home.packages = with pkgs; [
        soundux
        pavucontrol
        lsp-plugins
        calf
        rnnoise
        zam-plugins
        zita-convolver
        soundtouch
    ];

    services.easyeffects.enable = true;
}
