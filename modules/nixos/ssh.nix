{ ... }:
{
  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };
}
