{ ... }:
{
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
