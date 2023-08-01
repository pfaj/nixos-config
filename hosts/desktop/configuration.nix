{ pkgs, inputs, config, ... }:
let
    inherit (inputs)
        self
        home-manager
        ;
in
{
    imports = [
        ./hardware-configuration.nix
        ./override.nix
        home-manager.nixosModules.home-manager
    ]
    ++ (with self.nixosModules; [
        nix
        nixpkgs
        hm
        fonts
        gaming
        #kde
        #gnome
        hyprland
    ]);

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    zramSwap.enable = true;
    zramSwap.memoryPercent = 100;
    # zram is relatively cheap, prefer swap
    boot.kernel.sysctl."vm.swappiness" = 180;
    # zram is in memory, no need to readahead
    boot.kernel.sysctl."vm.page-cluster" = 0;
    # Start asynchronously writing at 128 MiB dirty memory
    boot.kernel.sysctl."vm.dirty_background_bytes" = 128 * 1024 * 1024;
    # Start synchronously writing at 50% dirty memory
    # boot.kernel.sysctl."vm.dirty_ratio" = 50;
    boot.kernel.sysctl."vm.dirty_bytes" = 64 * 1024 * 1024;
    boot.kernel.sysctl."vm.vfs_cache_pressure" = 500;

    # With 32 GiB of RAM and zram enabled OOM is unlikely
    systemd.oomd.enable = false;
    systemd.services.NetworkManager-wait-online.enable = false;
    #systemd.network.wait-online.enable = false;

    networking.hostName = "ben-nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

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

    # virtualization
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "ben" ];
    users.extraUsers.ben.extraGroups = [ "vboxusers" ];

    environment.etc = {
        "xdg/user-dirs.defaults".text = ''
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

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        neovim
        wget
        bindfs
        git
        htop

        # required by sddm theme
        pkgs.sddm-chili
        libsForQt5.qt5.qtgraphicaleffects
    ];

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services = {
        # Enable the X11 windowing system.
        xserver = {
            enable = true;
            videoDrivers = ["nvidia"];

            displayManager.sddm = {
                enable = true;
                theme = "sddm-chili";
            };

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

        flatpak.enable = true;
        printing.enable = true;
    };

    programs = {
        dconf.enable = true;
        fish = {
            enable = true;
            interactiveShellInit = ''
                set -U fish_greeting

                if type -q neofetch
                    neofetch
                end
            '';
        };
        droidcam.enable = true;
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # 25565 - Minecraft
    # 24454 - Minecraft voice chat mod
    # 57621 - Spotify discovery
    networking.firewall.allowedTCPPorts = [ 25565 57621 ];
    networking.firewall.allowedUDPPorts = [ 25565 24454 ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
}

