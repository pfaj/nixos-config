{
  inputs,
  pkgs,
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixos-hardware.nixosModules.microsoft-surface-common
  ];

  #microsoft-surface.ipts.enable = true; # custom surface-linux kernel required
  microsoft-surface.surface-control.enable = true;

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod_latest; # install custom xanmod kernel
    kernelModules = ["kvm-intel" "v4l2loopback" "snd-aloop"];
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback.out];
    extraModprobeConfig = ''
      options vl42loopback exclusive_caps=1 card_label="Virtual Camera"
    ''; # setup virtual cam

    initrd = {
      availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "sd_mod"];
      kernelModules = [];
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d380c93c-4ebb-48df-9cd3-3e2fa1424605";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8695-9BAA";
    fsType = "vfat";
  };

  fileSystems."/mnt/NixExpansion" = {
    device = "/dev/disk/by-uuid/1b98f0dd-4ccd-4336-a19a-f8f4d17d93a0";
    fsType = "ext4";
    options = ["noauto" "nofail"];
  };

  #   systemd.mounts."mnt-NixExpansion" = {
  #     what = "/dev/disk/by-uuid/1b98f0dd-4ccd-4336-a19a-f8f4d17d93a0";
  #     where = "/mnt/NixExpansion";
  #     options = "noatime,defaults";
  #     wantedBy = [ "local-fs.target" ];
  #   };
  #
  #   systemd.automounts."mnt-NixExpansion" = {
  #     where  = "/mnt/NixExpansion";
  #     wantedBy = [ "multi-user.target" ];
  #   };
  #
  #   systemd.services.after-NixExpansion-mount = {
  #     description = "Script after mounting external Nix store";
  #     requires = [ "mnt-NixExpansion.mount" ];
  #     after = [ "mnt-NixExpansion.mount" ];
  #     serviceConfig.Type = "oneshot";
  #     script = ''
  #       echo "substituters += file:///mnt/NixExpansion/store" >> /etc/nix/nix.conf
  #       echo "trusted-substituters += file:///mnt/NixExpansion/store" >> /etc/nix/nix.conf
  #       systemctl restart nix-daemon
  #     '';
  #   };
  #
  #   systemd.services.before-NixExpansion-unmount = {
  #     description = "Script before unmounting external Nix store";
  #     before = [ "mnt-NixExpansion.mount" ];
  #     serviceConfig.Type = "oneshot";
  #     script = ''
  #       sed -i '/NixExpansion/d' /etc/nix/nix.conf
  #       systemctl restart nix-daemon
  #     '';
  #   };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
