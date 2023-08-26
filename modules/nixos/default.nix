{
    default = import ./default;
    desktops = import ./desktops;

    fonts = import ./fonts.nix;
    gaming = import ./gaming.nix;
    nvidia = import ./nvidia.nix;
    sddm = import ./sddm.nix;
    ssh = import ./ssh.nix;
    virtualization = import ./virtualization.nix;
    zram = import ./zram.nix;
}
