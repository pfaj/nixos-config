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
        audio
        sddm
        ssh
        #virtualization
#         zram

#         desktops.gnome
        desktops.hyprland
#         desktops.kde
#         desktops.wayfire
    ]);

    users.users.ben = {
        isNormalUser = true;
        description = "Ben";
        extraGroups = [ "networkmanager" "wheel" "audio" ];
        shell = pkgs.fish;
    };
    home-manager.users.ben = import ./home.nix;

    services = {
        openssh.enable = true;

        syncthing.settings = {
            devices = {
                "surface-laptop" = {
                    id = "DVGBQSI-M7XLNZJ-I34CMWR-O4MJQKT-ZH4IGWA-DZO6MXS-SGI7BOH-SZKB4AL";
                };
                "samsung-phone" = {
                    id = "ILJUQUQ-55IYYIO-LBQ66ZC-7UZDPR3-FER5YO5-KRM2SDX-VXWOH6H-VLWOMQG";
                };
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
                "obsidian" = {
                    path = "/mnt/LinuxExpansion/Places/Documents/Obsidian";
                    devices = [ "surface-laptop" "samsung-phone" ];
                    versioning = {
                        type = "simple";
                        params = {
                            keep = "3";
                        };
                    };
                };
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

    environment.systemPackages = with pkgs; [
        latencyflex
    ];

    system.stateVersion = "23.11";
}

