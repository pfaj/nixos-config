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
    # adb
    nvidia
    davinci
    keyd
    logitech
    ssh
    # docker
    # ollama
    power-saving
    zen
    tailscale
    virtualization
    #mysql

    # desktops.hyprland
    desktops.niri
    #desktops.plasma6
  ]);

  nix.settings.download-buffer-size = 10485760;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="8087", ATTRS{idProduct}=="0033", TAG+="uaccess"
  '';

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "nvidia-drm.mode_set=1"
      "nvidia-drm.fbdev=1"
      "thinkpad_acpi.fan_control=1"
      "thinkpad_acpi.experimental=1"
      "coretemp"
    ];
    initrd.kernelModules = [ "thinkpad_acpi" ];
  };

  users.users.mono.extraGroups = [ "docker" ];

  powerManagement.cpuFreqGovernor = lib.mkForce "ondemand";

  home-manager.users.${username} = import ./home.nix;

  services.fprintd.enable = true;
  security.pam.services.swaylock = { };
  security.pam.services.swaylock.fprintAuth = true;

  # services.postgresql = {
  #   enable = true;
  #   ensureDatabases = ["mydatabase"];
  #   authentication = pkgs.lib.mkOverride 10 ''
  #     #type database  DBuser  auth-method
  #     local all        all      trust
  #   '';
  # };

  networking = {
    hostName = "thinkpad-laptop";
    # firewall = {
    #   allowedTCPPorts = [7236 7250];
    #   allowedUDPPorts = [51820 7236 5353];
    # };
  };

  networking.firewall.allowedTCPPorts = [ 5353 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 50000;
      to = 60000;
    }
  ];
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 50000;
      to = 60000;
    }
  ];

  # systemd.services.custom-auto-cpufreq = {
  #   description = "Custom auto-cpufreq - Automatic CPU speed & power optimizer";
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "network.target" ];
  #
  # serviceConfig = {
  #   Type = "simple";
  #   ExecStart = "${custom-auto-cpufreq}/bin/auto-cpufreq --daemon";
  #   Restart = "always";
  #   RestartSec = 15;
  # };
  # };

  # Make sure the package is available in the system
  # environment.systemPackages = [ custom-auto-cpufreq ];

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
