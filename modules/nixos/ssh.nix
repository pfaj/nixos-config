{
  services.openssh = {
    enable = true;
    #ports = [2222];

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      LogLevel = "VERBOSE"; # for jails to work
      X11Forwarding = true;
    };
  };

  services.fail2ban = {
    enable = true;
  };

  networking.firewall.allowedTCPPorts = [2222];
}
