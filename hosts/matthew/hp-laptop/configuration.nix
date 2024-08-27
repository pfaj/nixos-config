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

      desktops.plasma6
    ]);

  boot = {
    kernelPackages = lib.mkForce pkgs.linuxPackages;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  powerManagement.cpuFreqGovernor = lib.mkForce "ondemand";

  home-manager.users.${username} = import ./home.nix;

  services = {
    syncthing.settings = {
      devices = {
        "main-desktop".id = "2Z6PAMN-W3IBRFR-Z7JC3S4-JFQFY6T-TF4JVR5-F6XK3M4-HLOF7YE-OZF6PA4";
      };

      folders = {
        "nixos-config" = {
          devices = ["main-desktop"];
          path = "~/.config/nixos";
        };
      };
    };
  };
}
