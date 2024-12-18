{username, ...}: {
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      ip = "127.0.0.1";
    };
  };
  users.users.${username}.extraGroups = ["docker"];
  hardware.nvidia-container-toolkit.enable = true;
}
