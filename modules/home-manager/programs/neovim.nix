{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    # formatters
    alejandra # nix
    lua-language-server
    clang-tools
    black # python
    codespell # generalized spelling errors
    # rustfmt # rust
    nil
    emmet-ls
    prettierd
    #vscode-langservers-extracted # language servers for HTML/CSS/JSON/ESLint
    #kdePackages.qtdeclarative
    lazygit

    ctags # required for tagbar
    ripgrep # required for live grep
  ];
}
