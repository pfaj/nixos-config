{
  services.tlp = {
    enable = true;
    settings = {
      GPU_SCALING_GOVERNER_ON_BAT = "conservative";
      GPU_SCALING_GOVERNER_ON_AC = "ondemand";
      GPU_SCALING_MAX_FREQ_ON_AC = 0;
      WIFI_PWR_ON_AC = "off";
      MAX_LOST_WORK_SECS_ON_AC = 15;
    };
  };
}
