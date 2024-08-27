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
      ssh
      ollama
      power-saving

      desktops.hyprland
      #desktops.plasma6
    ]);

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  powerManagement.cpuFreqGovernor = lib.mkForce "ondemand";

  home-manager.users.${username} = import ./home.nix;

  services.fprintd.enable = true;

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };

  services = {
    syncthing.settings = {
      devices = {
        "main-desktop".id = "2Z6PAMN-W3IBRFR-Z7JC3S4-JFQFY6T-TF4JVR5-F6XK3M4-HLOF7YE-OZF6PA4";
        "thinkphone".id = "ADQLAJW-7ZNJ435-QVUVTZA-RBXW3OS-P37SIAQ-HQN5AGD-OXRM37V-3BDVYAH";
        "mono-desktop".id = "MDC3QPE-N6PPPUM-6TVWPFQ-2DNR4OG-4J3C6MB-5XP3J7A-FREPFEZ-PUBOYQN";
      };

      folders = {
        "nixos-config" = {
          devices = ["main-desktop"];
          path = "~/.config/nixos";
        };

        "quickshell" = {
          devices = ["main-desktop"];
          path = "~/.config/quickshell";
        };

        "ObsidianNotebook" = {
          devices = ["mono-desktop" "thinkphone"];
          path = "~/ObsidianNotebook";
        };
        "website" = {
          devices = ["mono-desktop"];
          path = "~/website";
        };
        "projects" = {
          devices = ["mono-desktop"];
          path = "~/projects/";
        };
      };
    };
  };

  systemd.services.copy-file = {
    description = "Backup quickshell";

    script = ''
      TIME=$(${pkgs.coreutils}/bin/date +%Y-%m-%d_%H-%M-%S)
      ${pkgs.gnutar}/bin/tar --exclude=.backup --absolute-names -czf /home/${username}/.config/quickshell/.backup/$TIME.tar.gz ~/.config/quickshell
    '';
  };

  systemd.timers.copy-file = {
    description = "quickshell backup timer";
    timerConfig = {
      OnBootSec = "15s";
      OnUnitActiveSec = "6h";
      Persistent = true;
    };
    wantedBy = ["timers.target"];
  };
}
