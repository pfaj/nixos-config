{pkgs, ...}: {
  xdg.desktopEntries."vesktop" = {
    categories = ["Network" "InstantMessaging" "Chat"];
    exec = "vesktop %U";
    genericName = "Internet Messenger";
    icon = "discord";
    settings = {
      Keywords = "discord;vencord;electron;chat";
      StartupWMClass = "Vesktop";
      Version = "1.4";
    };
    name = "Vesktop";
    type = "Application";
  };

  home.packages = [pkgs.vesktop];
}
