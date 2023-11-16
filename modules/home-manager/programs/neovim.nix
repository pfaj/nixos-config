{ pkgs, ... }:
{
    programs.neovim = {
        enable = true;
        plugins = with pkgs.vimPlugins; [
            nvim-treesitter
            nvim-treesitter-parsers.nix

            fzf-vim
            lightline-vim
            ale
            vim-gitgutter
            nerdtree
    ];
    extraConfig = ''
        set autochdir
        map ; :Files<CR>
        map <C-o> :NERDTreeToggle<CR>
    '';
    };
}
