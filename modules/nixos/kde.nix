{ pkgs, ... }: {
    services.xserver.desktopManager.plasma5.enable = true;

    xdg.portal.enable = true;

    environment.plasma5.excludePackages = with pkgs.libsForQt5; [
        oxygen
        elisa
        khelpcenter
    ];

    environment.systemPackages = with pkgs; [
        sierra-breeze-enhanced
        xwaylandvideobridge
    ];
}
