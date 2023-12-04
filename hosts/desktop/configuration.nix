{ pkgs
, inputs
, config
, username
, ...
}:
let
  inherit (inputs) self;
  nixosModules = with self.nixosModules; [
    core

    common
    gaming
    nvidia
    audio
    sddm
    ssh
    syncthing
    #virtualization
    wootility
    #zram

    #desktops.gnome
    desktops.hyprland
    #desktops.plasma5
    #desktops.plasma6
    #desktops.wayfire
  ];
in
{
  imports =
    [
      ./hardware-configuration.nix
    ] ++ nixosModules;

  home-manager.users.${username} = import ./home.nix;

  services.syncthing.settings = {
    devices = {
      "surface-laptop".id = "DVGBQSI-M7XLNZJ-I34CMWR-O4MJQKT-ZH4IGWA-DZO6MXS-SGI7BOH-SZKB4AL";
      "samsung-phone".id = "ILJUQUQ-55IYYIO-LBQ66ZC-7UZDPR3-FER5YO5-KRM2SDX-VXWOH6H-VLWOMQG";
    };

    folders = {
      "nixos-config" = {
        path = "/home/${username}/.config/nix/";
        devices = [ "surface-laptop" ];
        versioning = {
          type = "simple";
          params.keep = "10";
        };
      };

      "obsidian" = {
        path = "/mnt/LinuxExpansion/Places/Documents/Obsidian";
        devices = [ "surface-laptop" "samsung-phone" ];
        versioning = {
          type = "simple";
          params.keep = "3";
        };
      };
    };
  };

  # Open ports in the firewall.
  # 25565 - Minecraft
  # 24454 - Minecraft voice chat mod
  # 57621 - Spotify discovery
  # 22 - SSH
  networking = {
    firewall = {
      allowedTCPPorts = [ 25565 57621 22 ];
      allowedUDPPorts = [ 25565 24454 9943 ];
    };
  };

  environment.systemPackages = with pkgs; [
    latencyflex
  ];
}
