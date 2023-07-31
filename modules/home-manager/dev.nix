{ pkgs, ... }:
{
    home.packages = with pkgs; [
        conda
        jetbrains.idea-community
        cargo
        python3
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
    ];

    programs.vscode = {
        enable = true;
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        mutableExtensionsDir = true;
        extensions = with pkgs.vscode-extensions; [
            rust-lang.rust-analyzer
            arrterian.nix-env-selector
            ms-vscode.cpptools
            ms-vscode.cmake-tools
            ms-vscode.makefile-tools
            twxs.cmake
            ms-python.python
            ms-python.vscode-pylance
            bbenoist.nix
        ];
    };
}
