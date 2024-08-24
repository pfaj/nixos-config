{
  username,
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) self;
in {
  imports = with self.nixosModules; [
    sddm
  ];

  # imports plasma6 home-manager module
  home-manager.users.${username}.imports = [
    self.homeManagerModules.desktops.plasma6
  ];

  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
    elisa
    khelpcenter
  ];
}
