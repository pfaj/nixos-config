{ ... }:
{
  services.immich = {
    accelerationDevices = null;
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    openFirewall = true;
    mediaLocation = "/data/immich";
  };
}
