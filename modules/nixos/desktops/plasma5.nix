{ username, inputs, pkgs, ... }:
let
  inherit (inputs) self;
in
{
  # imports plasma5 home-manager module
  home-manager.users.${username}.imports = [
    self.homeManagerModules.desktops.plasma5
  ];

  services.xserver.desktopManager.plasma5.enable = true;

  xdg.portal.enable = true;

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    oxygen
    elisa
    khelpcenter
  ];
}
