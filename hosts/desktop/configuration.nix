{ inputs
, config
, pkgs
, lib
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
    rt-audio
    audio
    sddm
    ssh
    syncthing
    #virtualization
    wootility
    #zram

    desktops.cosmic
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
    ]
    ++ nixosModules;

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest; # install custom xanmod kernel
    kernelModules = [ "v4l2loopback" "snd-aloop" ];
    extraModulePackages = with config.boot.kernelPackages; [ rtl88x2bu v4l2loopback.out ];
    extraModprobeConfig = ''
      options vl42loopback exclusive_caps=1 card_label="Virtual Camera"
      options nvidia-modeset hdmi_deepcolor=1
    ''; # setup virtual cam and enable hdmi_deepcolor for Nvidia

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  fileSystems."/mnt/LinuxExpansion" = {
    device = "/dev/disk/by-uuid/3441c4de-e929-48b0-ac42-06290f4824ca";
    fsType = "ext4";
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/635dd7c6-377f-4d4d-bb5b-4ce5eb547ecd";
    }
  ];

  home-manager.users.${username} = import ./home.nix;

  services.syncthing.settings = {
    devices = {
      "surface-laptop".id = "DVGBQSI-M7XLNZJ-I34CMWR-O4MJQKT-ZH4IGWA-DZO6MXS-SGI7BOH-SZKB4AL";
      "samsung-phone".id = "ILJUQUQ-55IYYIO-LBQ66ZC-7UZDPR3-FER5YO5-KRM2SDX-VXWOH6H-VLWOMQG";
    };

    folders = {
      "nixos-config" = {
        path = "~/.config/nixos/";
        devices = ["surface-laptop"];
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
  # Syncthing - TCP: [ 8384 2000 ]
  #             UDP: [ 22000 21027 ]
  # 22 - SSH
  networking = {
    firewall = {
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };
}
