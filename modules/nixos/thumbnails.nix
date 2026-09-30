{pkgs, ...}: {
  # D-Bus thumbnail service. In nixpkgs this is built with libopenraw (RAW camera
  # files), ffmpegthumbnailer (video), libheif, libjxl and webp support, so file
  # managers that use Tumbler (Thunar, Nemo, PCManFM, ...) get previews.
  services.tumbler.enable = true;

  # Register extra gdk-pixbuf loaders for GTK-based apps and file managers
  # (Nautilus uses gdk-pixbuf to generate thumbnails). libopenraw decodes most
  # RAW formats; librsvg keeps SVG support present in the custom cache.
  programs.gdk-pixbuf.modulePackages = with pkgs; [
    librsvg
    libopenraw
  ];

  # Provides /share/thumbnailers entries consumed by GNOME's thumbnail factory
  # (video previews).
  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer
  ];
}
