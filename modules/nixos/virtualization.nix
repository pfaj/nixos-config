{ username, ... }:
{
  # virtualization
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ ${username} ];
  users.extraUsers.${username}.extraGroups = [ "vboxusers" ];
}
