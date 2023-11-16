{ pkgs, ... }:
{
    programs.vscode = {
        enable = true;
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        mutableExtensionsDir = true;
        extensions = with pkgs.vscode-extensions; [
            rust-lang.rust-analyzer
#             arrterian.nix-env-selector
#             ms-vscode.cpptools
#             ms-vscode.cmake-tools
#             ms-vscode.makefile-tools
#             twxs.cmake
#             ms-python.python
#             ms-python.vscode-pylance
#             bbenoist.nix
        ];
        userSettings = {
            "window.titleBarStyle" = "custom";
            "editor.smoothScrolling" = true;
            "editor.cursorBlinking" = "smooth";
            "editor.cursorSmoothCaretAnimation" = "on";
            "workbench.list.smoothScrolling" = true;
            "terminal.integrated.smoothScrolling" = true;
            "diffEditor.renderSideBySide" = false;
            "editor.inlayHints.enabled" = "off";
        };
    };
}
