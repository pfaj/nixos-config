{ pkgs, inputs, config, ... }:
let
    inherit (inputs) self home-manager;
in
{
    imports = [
        ./hardware-configuration.nix
    ]
    ++ (with self.nixosModules; [
        core
        common
        #gaming
        #nvidia
        pipewire
        sddm
        #ssh
        #virtualization
        #zram

        #desktops.gnome
        #desktops.hyprland
        desktops.kde
    ]);

    boot = {
        kernelPackages = pkgs.linuxPackages_xanmod_latest; # install custom xanmod kernel
        kernelModules = [ "kvm-intel" "v4l2loopback" "snd-aloop"];
        extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback.out ];
        extraModprobeConfig = ''
        options vl42loopback exclusive_caps=1 card_label="Virtual Camera"
        ''; # setup virtual cam

        initrd = {
            availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
            kernelModules = [];
        };

        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
    };

    users.users.ben = {
        isNormalUser = true;
        description = "Ben";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.fish;
    };
    home-manager.users.ben = import ./home.nix;

    services = {
        syncthing.settings = {
            devices = {
                "main-desktop" = {
                    id = "GWBQ6FT-OFHIDSB-KC4LYAO-GUKY7GJ-6QJ6X4O-4RA2X3P-O6V4QE6-YXCXNQE";
                };
                "samsung-phone" = {
                    id = "ILJUQUQ-55IYYIO-LBQ66ZC-7UZDPR3-FER5YO5-KRM2SDX-VXWOH6H-VLWOMQG";
                };
            };
        };
    };

    # For external nix store to work
    nix.settings = {
        substituters = [ "https://cache.nixos.org/ file:///mnt/NixExpansion/store" ];
        trusted-substituters = [ "file:///mnt/NixExpansion/store" ];
    };

    system.stateVersion = "23.05";
}

