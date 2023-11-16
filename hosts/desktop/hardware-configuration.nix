{ config, lib, pkgs, modulesPath, ... }:
{
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot = {
        kernelPackages = pkgs.linuxPackages_xanmod_latest; # install custom xanmod kernel
        kernelModules = [ "kvm-intel" "v4l2loopback" "snd-aloop"];
        extraModulePackages = with config.boot.kernelPackages; [ rtl88x2bu v4l2loopback.out ];
        extraModprobeConfig = ''
            options vl42loopback exclusive_caps=1 card_label="Virtual Camera"
            options nvidia-modeset hdmi_deepcolor=1
        ''; # setup virtual cam and enable hdmi_deepcolor for Nvidia

        initrd = {
            availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "nvme" "usb_storage" "sd_mod" ];
            kernelModules = [];
        };

        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
    };

    fileSystems."/" = {
        device = "/dev/disk/by-uuid/a5d5a58a-c4e0-4cc8-8630-8e72dd5cc1a8";
        fsType = "ext4";
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/CA11-25AB";
        fsType = "vfat";
    };

    fileSystems."/mnt/LinuxExpansion" = {
        device = "/dev/disk/by-uuid/3441c4de-e929-48b0-ac42-06290f4824ca";
        fsType = "ext4";
        #options = [ "uid=1000" ];
    };

    swapDevices = [
        {
            device = "/dev/disk/by-uuid/635dd7c6-377f-4d4d-bb5b-4ce5eb547ecd";
        }
    ];

    networking.useDHCP = lib.mkDefault true;
    #networking.interfaces.enp0s20f0u3.useDHCP = lib.mkDefault true;
    #networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
