{pkgs, ...}: let
  browser = "brave-browser.desktop";
  file-manager = "org.kde.dolphin.desktop";
in {
  home = {
    packages = with pkgs; [
      xdg-utils # provides cli tools such as `xdg-mime` `xdg-open`
      xdg-user-dirs
    ];
  };

  xdg = {
    enable = true;

    mimeApps = rec {
      enable = true;

      associations.added = defaultApplications;
      defaultApplications = {
        "inode/directory" = file-manager;

        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "text/html" = browser;
      };
    };
  };
}
