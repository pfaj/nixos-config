{pkgs, ...}: {
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  hardware.system76.power-daemon.enable = true;

  services = {
    #thermald = {
    #  enable = true;
    #  configFile = ./thermal-conf.xml;
    #};

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "conservative";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };
}
