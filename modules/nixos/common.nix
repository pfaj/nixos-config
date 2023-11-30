{ pkgs, inputs, ... }:
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

  security.sudo.wheelNeedsPassword = false;

  networking = {
    hostName = "ben-nixos";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  services = {
    flatpak.enable = true;
    printing.enable = true;

    mullvad-vpn = {
      enable = true;
      enableExcludeWrapper = false;
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
    wget
    bindfs
    git
		git-lfs
    htop
    neofetch

    # custom neovim setup
    inputs.neovim-flake.packages.${pkgs.system}.nix
  ];
}
