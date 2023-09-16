{ pkgs, inputs, config, ... }:
let
    inherit (inputs) self home-manager;
in
{
    imports = [
        ./hardware-configuration.nix
        ./overrides.nix
    ]
    ++ (with self.nixosModules; [
        core
        common
        gaming
        nvidia
        pipewire
        sddm
        ssh
        #virtualization
        zram

        #desktops.gnome
        desktops.hyprland
#         desktops.kde
    ]);

    boot = {
        kernelPackages = pkgs.linuxPackages_xanmod_latest; # install custom xanmod kernel
        kernelModules = [ "kvm-intel" "v4l2loopback" "snd-aloop"];
        extraModulePackages = with config.boot.kernelPackages; [ rtl88x2bu v4l2loopback.out ];
        extraModprobeConfig = ''
            options vl42loopback exclusive_caps=1 card_label="Virtual Camera"
        ''; # setup virtual cam

        initrd = {
            availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "nvme" "usb_storage" "sd_mod" ];
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
        flatpak.enable = true;
        openssh.enable = true;

        syncthing.settings = {
            devices = {
                "surface-laptop" = {
                    id = "5T35XEK-CJHEG4W-XLPU2QL-UAF7AI3-FZRAA2S-UCCPKFZ-ZIYKFL4-QNR2HQL";
                };
#                 "samsung-phone" = {
#                     id = "ILJUQUQ-55IYYIO-LBQ66ZC-7UZDPR3-FER5YO5-KRM2SDX-VXWOH6H-VLWOMQG";
#                 };
            };
            folders = {
                "nixos-config" = {
                    path = "/home/ben/.config/nix/";
                    devices = [ "surface-laptop" ];
                    versioning = {
                        type = "simple";
                        params = {
                            keep = "10";
                        };
                    };
                };
#                 "obsidian" = {
#                     path = "/mnt/LinuxExpansion/Places/Documents/Obsidian";
#                     devices = [ "surface-laptop" "samsung-phone" ];
#                     versioning = {
#                         type = "simple";
#                         params = {
#                             keep = "3";
#                         };
#                     };
#                 };
            };
        };
    };

    # Open ports in the firewall.
    # 25565 - Minecraft
    # 24454 - Minecraft voice chat mod
    # 57621 - Spotify discovery
    # 22 - SSH
    networking = {
        firewall = {
            allowedTCPPorts = [ 25565 57621 22 ];
            allowedUDPPorts = [ 25565 24454 ];
        };
    };

    system.stateVersion = "23.05";
}

