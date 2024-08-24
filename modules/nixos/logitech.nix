{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    solaar
  ];

  hardware.logitech = {
    wireless.enable = true;
    wireless.enableGraphical = true;
  };
}
