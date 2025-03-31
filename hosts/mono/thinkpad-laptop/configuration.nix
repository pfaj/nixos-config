{
  pkgs,
  lib,
  username,
  inputs,
  ...
}: let
  inherit (inputs) self;
  custom-auto-cpufreq = pkgs.auto-cpufreq.overrideAttrs (oldAttrs: {
    src = pkgs.fetchFromGitHub {
      owner = "AdnanHodzic";
      repo = "auto-cpufreq";
      rev = "8f026ac6497050c0e07c55b751c4b80401e932ec";
      sha256 = "sha256-AJH2wgat6ssid3oYb0KBgO4qxhZD6/OWNHwYj11Yfy4=";
    };
    patches = [];
    propagatedBuildInputs =
      oldAttrs.propagatedBuildInputs
      or []
      ++ [
        pkgs.python3Packages.requests
        pkgs.python3Packages.urwid
      ];
  });
in {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (with self.nixosModules; [
      common
      nvidia
      ssh
      docker
      ollama
      power-saving
      zen
      #mysql

      # desktops.hyprland
      desktops.niri
      #desktops.plasma6
    ]);

  nix.settings.download-buffer-size = 10485760; # 10 MiB (default is around 1 MiB)>>
  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = ["nvidia-drm.mode_set=1" "nvidia-drm.fbdev=1" "thinkpad_acpi.fan_control=1" "thinkpad_acpi.experimental=1"];
    initrd.kernelModules = ["thinkpad_acpi"];
  };

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  powerManagement.cpuFreqGovernor = lib.mkForce "ondemand";

  home-manager.users.${username} = import ./home.nix;

  services.fprintd.enable = true;
  security.pam.services.swaylock = {};
  security.pam.services.swaylock.fprintAuth = true;

  #services.postgresql = {
  #  enable = true;
  #  ensureDatabases = ["mydatabase"];
  #  authentication = pkgs.lib.mkOverride 10 ''
  #    #type database  DBuser  auth-method
  #    local all       all     trust
  #  '';
  #};

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

  networking = {
    hostName = "thinkpad-laptop";
    #firewall = {
    #  allowedTCPPorts = [7236 7250];
    #  allowedUDPPorts = [51820 7236 5353];
    #};
  };

  systemd.services.custom-auto-cpufreq = {
    description = "Custom auto-cpufreq - Automatic CPU speed & power optimizer";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${custom-auto-cpufreq}/bin/auto-cpufreq --daemon";
      Restart = "always";
      RestartSec = 15;
    };
  };

  # Make sure the package is available in the system
  environment.systemPackages = [custom-auto-cpufreq];

  # services = {
  #   syncthing.settings = {
  #     devices = {
  #       "main-desktop".id = "2Z6PAMN-W3IBRFR-Z7JC3S4-JFQFY6T-TF4JVR5-F6XK3M4-HLOF7YE-OZF6PA4";
  #       "thinkphone".id = "ADQLAJW-7ZNJ435-QVUVTZA-RBXW3OS-P37SIAQ-HQN5AGD-OXRM37V-3BDVYAH";
  #       "mono-desktop".id = "MDC3QPE-N6PPPUM-6TVWPFQ-2DNR4OG-4J3C6MB-5XP3J7A-FREPFEZ-PUBOYQN";
  #     };
  #
  #     folders = {
  #       "ObsidianNotebook" = {
  #         devices = ["mono-desktop" "thinkphone"];
  #         path = "~/ObsidianNotebook";
  #       };
  #       "website" = {
  #         devices = ["mono-desktop"];
  #         path = "~/website";
  #       };
  #       "projects" = {
  #         devices = ["mono-desktop"];
  #         path = "~/projects/";
  #       };
  #     };
  #   };
  # };
}
