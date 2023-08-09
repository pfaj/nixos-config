{ ... }:
{
    services.openssh = {
        enable = true;
        permitRootLogin = "yes";
        passwordAuthentication = true;
    };
}
