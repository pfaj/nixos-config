{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = with inputs.self.homeManagerModules; [
    common
  ];

  wayland.windowManager.hyprland.settings = {
    input = {
      sensitivity = lib.mkForce 0.5;
      accel_profile = "adaptive";
    };
  };
}
