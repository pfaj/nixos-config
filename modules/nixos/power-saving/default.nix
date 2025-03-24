{pkgs, ...}: {
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  hardware.system76.power-daemon.enable = true;

  environment.systemPackages = with pkgs; [
    lm_sensors
    stress-ng
  ];

  services = {
    thermald = {
      enable = true;
      configFile = ./thermal-conf.xml;
    };

    # auto-cpufreq = {
    #   # enable = true;
    #   settings = {
    #     battery = {
    #       governor = "conservative";
    #       turbo = "never";
    #     };
    #     charger = {
    #       governor = "performance";
    #       turbo = "auto";
    #     };
    #   };
    # };
  };
}
