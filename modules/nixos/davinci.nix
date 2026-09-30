{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    davinci-resolve-studio
  ];

  # Gives access to studio dongle
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="096e", MODE="0664", GROUP="users", TAG+="uaccess"
  '';
}
