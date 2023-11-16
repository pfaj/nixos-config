{ pkgs, ... }:
{
    home.packages = with pkgs; [
#         conda
#         jetbrains.idea-community
        cargo
        neofetch
        openjdk
        nodejs
        gnumake
        jq
        cmake
        ninja
        pkg-config
        gcc
        xorg.xeyes
        socat
        ripgrep
        partition-manager
        filelight
        gh
        git-lfs
        jaq
    ];
}
