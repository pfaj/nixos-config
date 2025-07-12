{
  adb = import ./adb.nix;
  audio = import ./audio.nix;
  core = import ./core;
  common = import ./common.nix;
  docker = import ./docker.nix;
  desktops = import ./desktops;
  gaming = import ./gaming.nix;
  immich = import ./immich.nix;
  kdeconnect = import ./kdeconnect.nix;
  logitech = import ./logitech.nix;
  mysql = import ./mysql.nix;
  nextcloud = import ./nextcloud.nix;
  nvidia = import ./nvidia.nix;
  power-saving = import ./power-saving;
  rt-audio = import ./rt-audio.nix;
  searxng = import ./searxng.nix;
  sddm = import ./sddm.nix;
  ssh = import ./ssh.nix;
  syncthing = import ./syncthing.nix;
  tailscale = import ./tailscale.nix;
  tlp = import ./tlp.nix;
  virtualization = import ./virtualization.nix;
  ollama = import ./ollama.nix;
  wootility = import ./wootility.nix;
  zen = import ./zen.nix;
  zram = import ./zram.nix;
}
