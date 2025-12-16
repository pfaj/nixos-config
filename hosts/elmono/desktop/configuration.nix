{
  pkgs,
  lib,
  username,
  inputs,
  ...
}:
let
  inherit (inputs) self;
in
{
  imports = [
    ./hardware-configuration.nix
  ]
  ++ (with self.nixosModules; [
    common
    nvidia
    ssh
    gaming
    ollama
    zen
    searxng
    tailscale
    immich

    # desktops.hyprland
    desktops.niri
  ]);

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_lts;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  nixpkgs.config.allowUnfree = true;

  powerManagement.cpuFreqGovernor = lib.mkForce "ondemand";

  home-manager.users.${username} = import ./home.nix;

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };

  networking = {
    hostName = "${username}-desktop-nixos";
    firewall = {
      allowedTCPPorts = [ 22565 ];
      allowedUDPPorts = [ ];
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
