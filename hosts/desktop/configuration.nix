{ pkgs, inputs, config, ... }:
let
    inherit (inputs) self home-manager;
in
{
    imports = [
        ./hardware-configuration.nix
        ./override.nix
        home-manager.nixosModules.home-manager
    ]
    ++ (with self.nixosModules; [
        fonts
        gaming
        hm
        nix
        nixpkgs
        nvidia
        sddm
        ssh
        virtualization
        zram

        #gnome
        hyprland
        #kde
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
    };

    hardware = {
        enableAllFirmware = true;
        enableRedistributableFirmware = true;

        opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
        };
    };

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Set your time zone.
    time.timeZone = "America/New_York";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.ben = {
        isNormalUser = true;
        description = "Ben";
        extraGroups = [ "networkmanager" "wheel" ];
        shell = pkgs.fish;
    };
    home-manager.users.ben = import ../../users/ben/home.nix;

    environment = {
        etc = {"xdg/user-dirs.defaults".text = ''
                DESKTOP=/mnt/LinuxExpansion/Places/Desktop
                DOWNLOAD=/mnt/LinuxExpansion/Places/Downloads
                TEMPLATES=/mnt/LinuxExpansion/Places/Templates
                PUBLICSHARE=/mnt/LinuxExpansion/Places/PublicShare
                DOCUMENTS=/mnt/LinuxExpansion/Places/Documents
                MUSIC=/mnt/LinuxExpansion/Places/Audio
                PICTURES=/mnt/LinuxExpansion/Places/Images
                VIDEOS=/mnt/LinuxExpansion/Places/Videos
            '';
        };

        systemPackages = with pkgs; [
            neovim
            wget
            bindfs
            git
            htop
        ];
    };

    # enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services = {
        flatpak.enable = true;
        printing.enable = true;
        #openssh.enable = true;

        # enable the X11 windowing system.
        xserver = {
            enable = true;
            videoDrivers = ["nvidia"];

            layout = "us";
            xkbVariant = "";
        };

        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };
    };

    programs = {
        dconf.enable = true;
        droidcam.enable = true;

        fish = {
            enable = true;
            interactiveShellInit = ''
                set -U fish_greeting

                if type -q neofetch
                    neofetch
                end
            '';
        };

        # Some programs need SUID wrappers, can be configured further or are
        # started in user sessions.
        mtr.enable = true;
        gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
        };
    };

    # Open ports in the firewall.
    # 25565 - Minecraft
    # 24454 - Minecraft voice chat mod
    # 57621 - Spotify discovery
    # 22 - SSH
    networking = {
        hostName = "ben-nixos";
        networkmanager.enable = true;

        firewall = {
            allowedTCPPorts = [ 25565 57621 22 ];
            allowedUDPPorts = [ 25565 24454 ];
        };
    };

    system.stateVersion = "23.05";
}

