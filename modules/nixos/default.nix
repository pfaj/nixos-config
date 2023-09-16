{
    core = import ./core;
    common = import ./common.nix;
    desktops = import ./desktops;
    gaming = import ./gaming.nix;
    nvidia = import ./nvidia.nix;
    pipewire = import ./pipewire.nix;
    sddm = import ./sddm.nix;
    ssh = import ./ssh.nix;
    virtualization = import ./virtualization.nix;
    zram = import ./zram.nix;
}
