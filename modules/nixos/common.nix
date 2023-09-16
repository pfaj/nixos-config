{ pkgs, ... }:
{
    # Set your time zone.
    time.timeZone = "America/New_York";

    # Select internationalisation properties.
    i18n = {
        defaultLocale = "en_US.UTF-8";

        extraLocaleSettings = {
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
    };

    hardware = {
        enableAllFirmware = true;
        enableRedistributableFirmware = true;

        bluetooth.enable = true;

        opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
        };
    };

    networking = {
        hostName = "ben-nixos";
        networkmanager.enable = true;
    };

    systemd.services.NetworkManager-wait-online.enable = false;

    services = {
        printing.enable = true;

        mullvad-vpn = {
            enable = true;
            enableExcludeWrapper = false;
        };
        syncthing = {
            enable = true;
            user = "ben";
            dataDir = "/home/ben/Documents";
            configDir = "/home/ben/.config/syncthing";
            openDefaultPorts = true;
            overrideDevices = true;
            overrideFolders = true;
        };
        xserver = {
            enable = true;

            layout = "us";
            xkbVariant = "";
        };
    };

    programs = {
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
    };

    environment.systemPackages = with pkgs; [
        neovim
        wget
        bindfs
        git
        htop
        neofetch
    ];
}
