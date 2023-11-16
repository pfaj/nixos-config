{
    programs = import ./programs;
    services = import ./services;
    desktops = import ./desktops;
    theme = import ./theme;

    common = import ./common.nix;
    home = import ./home.nix;
    xdg = import ./xdg.nix;
}
