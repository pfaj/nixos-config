{ username, ... }:
{
  # virtualization
  # virtualisation.virtualbox.host.enable = true;
  # users.users.${username}.extraGroups = ["vboxusers"];
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = [ "${username}" ];

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
}
