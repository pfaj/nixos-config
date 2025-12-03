{
  pkgs,
  username,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    android-studio
  ];

  programs.adb.enable = true;
  users.users.${username}.extraGroups = [ "adbusers" ];

}
