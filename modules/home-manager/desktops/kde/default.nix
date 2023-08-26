{ pkgs, ... }:
{
    home.packages = with pkgs; [
        sierra-breeze-enhanced
    ];

    home.file.".config/kwinrc".source = ./kwinrc;
}
