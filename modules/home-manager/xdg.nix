{
  pkgs,
  lib,
  ...
}:
let
  #browser = "brave-browser.desktop";
  browser = "zen.desktop";
  file-manager = "org.gnome.Nautilus.desktop";

  # nomacs is a Qt image viewer with RAW support (libraw) and a thumbnail panel.
  image-viewer = "nomacs.desktop";
  video-player = "vlc.desktop";

  imageMimeTypes = [
    # Common
    "image/png"
    "image/jpeg"
    "image/gif"
    "image/webp"
    "image/bmp"
    "image/tiff"
    "image/svg+xml"
    "image/avif"
    "image/heif"
    "image/jxl"
    # RAW
    "image/x-adobe-dng"
    "image/x-canon-cr2"
    "image/x-canon-cr3"
    "image/x-canon-crw"
    "image/x-nikon-nef"
    "image/x-nikon-nrw"
    "image/x-sony-arw"
    "image/x-sony-sr2"
    "image/x-olympus-orf"
    "image/x-panasonic-rw2"
    "image/x-pentax-pef"
    "image/x-fuji-raf"
    "image/x-samsung-srw"
    "image/x-dcraw"
  ];

  videoMimeTypes = [
    "video/mp4"
    "video/mpeg"
    "video/ogg"
    "video/quicktime"
    "video/webm"
    "video/x-matroska"
    "video/x-msvideo"
    "video/x-flv"
    "video/3gpp"
    "video/x-ms-wmv"
    "video/x-m4v"
    "video/mp2t"
    "video/x-mpegurl"
  ];
in
{
  home = {
    packages = with pkgs; [
      xdg-utils # provides cli tools such as `xdg-mime` `xdg-open`
      xdg-user-dirs

      vlc
      nomacs
    ];
  };

  xdg = {
    enable = true;

    mimeApps = rec {
      enable = true;

      associations.added = defaultApplications;
      defaultApplications =
        (lib.genAttrs imageMimeTypes (_: image-viewer))
        // (lib.genAttrs videoMimeTypes (_: video-player))
        // {
          "inode/directory" = file-manager;

          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;
          "text/html" = browser;
        };
    };
  };
}
