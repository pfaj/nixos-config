{ pkgs, ... }:
{
    home.packages = with pkgs; [
        okular
        sierra-breeze-enhanced
    ];

    home.file.".config/kwinrc".source = ./kwinrc;
}
