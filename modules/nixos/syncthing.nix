{ ... }:
{
  services.syncthing = {
    enable = true;
    user = "ben";
    openDefaultPorts = true;
    systemService = true;
    dataDir = "/home/ben/syncthing";
    configDir = "/home/ben/.config/syncthing";
  };
}
