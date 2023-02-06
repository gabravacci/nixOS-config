{ config, lib, pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;

      plugins = with pkgs.vimPlugins; [
	 # Syntax
	 vim-nix
         nvim-treesitter
	 
	 # File Tree
	 nerdtree

         # TeX
         vimtex
         ultisnips

         # Colorscheme
         catppuccin-nvim
         dracula-nvim
         kanagawa-nvim
      ];
      extraConfig = ''
        set number
        set relativenumber
        set cursorline

        set termguicolors

        set showbreak = "↳"

        set foldenable
        set modelines=1
        set expandtab
        set foldlevel=99
        set foldmethod=indent

	syntax enable

        let g:tex_flavors='latex'
        let g:vimtex_view_method='zathura'
        let g:vimtex_view_general_viewer = 'zathura'

        set conceallevel=1

        colorscheme kanagawa
      '';
    };
  };

  home.file.".config/nvim/UltiSnips/tex.snippets".source = ./tex.snippets;
}
