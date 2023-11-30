{ inputs
, pkgs
, ...
}: {
  environment = {
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    };

    systemPackages = with pkgs; [
      piper # mouse dpi settings
      protontricks
      steamtinkerlaunch
    ];
  };

  services = {
    ratbagd.enable = true; # required by piper
  };

  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode.enable = true;
    steam = {
      enable = true;
      # fix gamescope inside steam
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            keyutils
            libkrb5
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
          ];
      };
    };
  };
}
