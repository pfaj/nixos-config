{
  programs = import ./programs;
  services = import ./services;
  desktops = import ./desktops;
  theme = import ./theme;
  common = import ./common.nix;
  home = import ./home.nix;
  shell = import ./shell.nix;
  xdg = import ./xdg.nix;
}
