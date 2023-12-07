{
  username,
  inputs,
  ...
}: let
  inherit (inputs) self home-manager;
in {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (with self.nixosModules; [
      core

      common
      #gaming
      #nvidia
      #rt-audio
      audio
      sddm
      #ssh
      syncthing
      #virtualization
      #wootility
      #zram

      #desktops.gnome
      desktops.hyprland
      #desktops.plasma5
      #desktops.plasma6
      #desktops.wayfire
    ]);

  home-manager.users.${username} = import ./home.nix;

  services = {
    syncthing.settings = {
      devices = {
        "main-desktop".id = "Y3KNUJG-DJY2DKX-IXFY2DW-TNOAXLT-UO5LAD2-LV5WTKQ-PP22O6C-ETZ2FQV";
        "samsung-phone".id = "ILJUQUQ-55IYYIO-LBQ66ZC-7UZDPR3-FER5YO5-KRM2SDX-VXWOH6H-VLWOMQGWOMQG";
      };

      folders = {
        "nixos-config" = {
          devices = ["main-desktop"];
          path = "~/.config/nix";
        };

        "obsidian" = {
          devices = ["main-desktop" "samsung-phone"];
          path = "~/Documents/Obsidian";
        };
      };
    };

    tlp.enable = true;
  };
}
