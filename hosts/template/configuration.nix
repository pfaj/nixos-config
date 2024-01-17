{
  inputs,
  username,
  ...
}: let
  inherit (inputs) self;
  nixosModules = with self.nixosModules; [
    core

    common
    #gaming
    #nvidia
    #rt-audio
    audio
    #sddm
    #ssh
    #syncthing
    #tlp
    #virtualization
    #wootility
    #zram

    #desktops.cosmic
    #desktops.gnome
    desktops.hyprland
    #desktops.plasma5
    #desktops.plasma6
    #desktops.wayfire
  ];
in {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ nixosModules;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  home-manager.users.${username} = import ./home.nix;
}
