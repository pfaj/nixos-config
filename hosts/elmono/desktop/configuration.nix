{
  pkgs,
  lib,
  username,
  inputs,
  ...
}: let
  inherit (inputs) self;
in {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (with self.nixosModules; [
      common
      nvidia
      davinci
      keyd
      logitech
      ssh
      gaming
      zen
      tailscale

      # desktops.hyprland
      desktops.niri
    ]);

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # NOTE: desktop with an AMD iGPU + NVIDIA dGPU. Verify the real bus IDs on
  # this machine before relying on them:
  #   lspci -D -nn | grep -Ei 'vga|3d|display'
  # The values below assume the AMD iGPU at 00:02.0 and the NVIDIA GPU at
  # 01:00.0; adjust if `lspci` reports different addresses.
  hardware.nvidia = {
    # Laptop-only power management is not appropriate on a desktop.
    powerManagement.enable = lib.mkForce false;
    powerManagement.finegrained = lib.mkForce false;
    prime = {
      # `nvidia.nix` defaults to an Intel iGPU, so clear that and use AMD.
      intelBusId = lib.mkForce "";
      amdgpuBusId = lib.mkForce "PCI:0:2:0";
      nvidiaBusId = lib.mkForce "PCI:1:0:0";
    };
  };

  boot.loader.systemd-boot.configurationLimit = 2;
  boot.initrd.compressor = "xz";

  powerManagement.cpuFreqGovernor = lib.mkForce "ondemand";

  home-manager.users.${username} = import ./home.nix;

  # Moved out of wayland.windowManager.hyprland.settings (where they were
  # written as raw Hyprland config and had no effect).
  programs.dconf.enable = true;

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
    server = {
      port = 6742;
    };
  };

  networking = {
    hostName = "${username}-desktop-nixos";
    firewall = {
      allowedTCPPorts = [22565];
      allowedUDPPorts = [];
    };
  };

  fileSystems = {
    "/data" = {
      device = "/dev/disk/by-uuid/034dd298-17d5-4084-bd15-c6f213ca35fc";
      fsType = "ext4";
      options = [
        "defaults"
        "nofail"
        "noatime"
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /data 0777 root root -"
  ];

  # services = {
  #   syncthing.settings = {
  #     devices = {
  #       "main-desktop".id = "2Z6PAMN-W3IBRFR-Z7JC3S4-JFQFY6T-TF4JVR5-F6XK3M4-HLOF7YE-OZF6PA4";
  #       "thinkphone".id = "ADQLAJW-7ZNJ435-QVUVTZA-RBXW3OS-P37SIAQ-HQN5AGD-OXRM37V-3BDVYAH";
  #       "thinkpad-laptop".id = "IGL6Y24-HLWHS6L-CMNZ2YA-2OQLWPQ-W3QAQX2-ZZ5RN44-336PXTH-FV4QFQL";
  #       "mono-tab".id = "BSC7U6T-QOOETLU-N4YDASY-YFE4WKO-CHHN4LU-AZHCUKN-LQMUPZA-ORDOVAR";
  #       "thinkpad-windows".id = "BMMBHBN-2EJA2KZ-4BCEVAP-P26ZW27-WDHBQ5N-UZHGWUM-JFJ6JQG-C5FOUQF";
  #     };
  #
  #     folders = {
  #       "nixos-config" = {
  #         devices = ["main-desktop" "thinkphone"];
  #         path = "~/.config/nixos";
  #       };
  #
  #       "quickshell" = {
  #         devices = ["main-desktop" "thinkphone"];
  #         path = "~/.config/quickshell";
  #       };
  #
  #       "ObsidianNotebook" = {
  #         devices = ["thinkpad-laptop" "thinkphone" "mono-tab" "thinkpad-windows"];
  #         path = "~/ObsidianNotebook";
  #       };
  #       "website" = {
  #         devices = ["thinkpad-laptop"];
  #         path = "~/website";
  #       };
  #       "projects" = {
  #         devices = ["thinkpad-laptop" "thinkpad-windows"];
  #         path = "~/projects/";
  #       };
  #     };
  #   };
  # };
  #
}
