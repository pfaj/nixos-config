{ ... }:
{
  # virtualization
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "ben" ];
  users.extraUsers.ben.extraGroups = [ "vboxusers" ];
}
