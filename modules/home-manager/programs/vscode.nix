{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    profiles.default.enableUpdateCheck = false;
    profiles.default.enableExtensionUpdateCheck = false;
    mutableExtensionsDir = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      rust-lang.rust-analyzer
      #arrterian.nix-env-selector
      #ms-vscode.cpptools
      #ms-vscode.cmake-tools
      #ms-vscode.makefile-tools
      #twxs.cmake
      #ms-python.python
      #ms-python.vscode-pylance
      vscjava.vscode-java-pack
    ];

    profiles.default.userSettings = {
      "window.titleBarStyle" = "custom";
      "editor.smoothScrolling" = true;
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.formatOnSave" = true;
      "workbench.list.smoothScrolling" = true;
      "terminal.integrated.smoothScrolling" = true;
      "diffEditor.renderSideBySide" = false;
      "editor.inlayHints.enabled" = "off";
      "dotnet.server.useOmnisharp" = true;
      "nix.enableLanguageServer" = true;
      "java.configuration.runtimes" = [
        {
          "name" = "JavaSE-17";
          "path" = "${pkgs.jdk17}/lib/openjdk/";
          "default" = true;
        }
      ];
      "java.configuration.detectJdksAtStart" = false;
      "redhat.telemetry.enabled" = false;
      "workbench.colorTheme" = "Atom One Dark";
    };
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };
}
