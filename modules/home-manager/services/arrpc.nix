{ pkgs, ... }:
{
    systemd.user.services.arrpc = {
        Install.WantedBy = [ "multi-user.target" ];
        Service = {
            ExecStart = "${pkgs.arrpc}/bin/start-arrpc";
            Environment = "PATH=${pkgs.nodejs}/bin";
        };
    };
}
