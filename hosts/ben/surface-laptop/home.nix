{
  lib,
  inputs,
  ...
}: let
  inherit (inputs) self;
  homeManagerModules = with self.homeManagerModules; [
    common

    #services.easy-effects
  ];
in {
  imports = homeManagerModules;

  wayland.windowManager.hyprland.settings = {
    exec-once = [
    ];

    monitor = ["eDP-1,preferred,auto,1.566667,bitdepth,10"];

    workspace = ["eDP-1,1"];

    input = {
      sensitivity = lib.mkForce 0.5;
      accel_profile = "adaptive";
    };
  };
}
