{ username, pkgs, inputs, config, ... }:
let
  inherit (inputs) self home-manager;
in
{
  imports = [
    ./hardware-configuration.nix
  ]
  ++ (with self.nixosModules; [
    core

    common
    #gaming
    #nvidia
    audio
    sddm
    #ssh
    #virtualization
    #zram
  ]);

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest; # install custom xanmod kernel
    kernelModules = [ "kvm-intel" "v4l2loopback" "snd-aloop" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback.out ];
    extraModprobeConfig = ''
      options vl42loopback exclusive_caps=1 card_label="Virtual Camera"
    ''; # setup virtual cam

    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  home-manager.users.${username} = import ./home.nix;

  services = {
    iptsd.enable = true;

    syncthing.settings = {
      devices = {
        "main-desktop" = {
          id = "Y3KNUJG-DJY2DKX-IXFY2DW-TNOAXLT-UO5LAD2-LV5WTKQ-PP22O6C-ETZ2FQV";
        };
        "samsung-phone" = {
          id = "ILJUQUQ-55IYYIO-LBQ66ZC-7UZDPR3-FER5YO5-KRM2SDX-VXWOH6H-VLWOMQG";
        };
      };
    };
  };

  # For external nix store to work
  nix.settings = {
    substituters = [ "https://cache.nixos.org/ file:///mnt/NixExpansion/store" ];
    trusted-substituters = [ "file:///mnt/NixExpansion/store" ];
  };

  system.stateVersion = "23.05";
}

