{ inputs, pkgs, ... }: {
    imports = [
        inputs.plasma6.nixosModules.default
    ];

    services.xserver.desktopManager.plasma6.enable = true;
    xdg.portal.enable = true;
}
