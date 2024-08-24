{username, ...}: {
  services.syncthing = {
    enable = true;
    user = username;
    openDefaultPorts = true;
    systemService = true;
    dataDir = "/home/${username}/syncthing";
    configDir = "/home/${username}/.config/syncthing";
  };
}
