# XDG stands for "Cross-Desktop Group", with X used to mean "cross".
# It's a bunch of specifications from freedesktop.org intended to standardize desktops and
# other GUI applications on various systems (primarily Unix-like) to be interoperable:
#   https://www.freedesktop.org/wiki/Specifications/
{ pkgs
, ...
}:
let
  browser = "brave-browser.desktop";
  file-manager = "org.kde.dolphin.desktop";
in
{
  home = {
    packages = with pkgs; [
      xdg-utils # provides cli tools such as `xdg-mime` `xdg-open`
      xdg-user-dirs
    ];

    #         sessionVariables.DEFAULT_BROWSER = "${pkgs.brave}/bin/brave";
  };

  xdg = {
    enable = true;

    mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/unknown" = browser;
        "inode/directory" = file-manager;
      };
    };
  };
}
