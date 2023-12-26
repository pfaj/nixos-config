{
  core = import ./core;
  common = import ./common.nix;
  desktops = import ./desktops;
  gaming = import ./gaming.nix;
  nvidia = import ./nvidia.nix;
  rt-audio = import ./rt-audio.nix;
  audio = import ./audio.nix;
  sddm = import ./sddm.nix;
  ssh = import ./ssh.nix;
  syncthing = import ./syncthing.nix;
  tlp = import ./tlp.nix;
  virtualization = import ./virtualization.nix;
  wootility = import ./wootility.nix;
  zram = import ./zram.nix;
}
