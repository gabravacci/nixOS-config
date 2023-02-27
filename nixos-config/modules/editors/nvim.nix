{ config, lib, pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;

      plugins = with pkgs.vimPlugins; [
	 # Syntax
	 vim-nix
         nvim-treesitter

         # QoL
         nvim-navic
         auto-pairs
         vim-lastplace

         # Detailing
         lightline-vim
         indent-blankline-nvim
	 
	 # File Tree
	 nerdtree

         # TeX
         vimtex
         ultisnips

         # Looks
         catppuccin-nvim
         dracula-nvim
         kanagawa-nvim
         onenord-nvim
         tokyonight-nvim
         nvim-web-devicons
      ];
      extraConfig = ''
        set number
        set relativenumber
        set cursorline
        set termguicolors
        colorscheme dracula
        set showbreak = "↳"
        set modeline
        set modelines=5
        set foldmethod=indent
	syntax enable
        let g:UltiSnipsExpandTrigger = '<tab>'
        let g:UltiSnipsJumpForwardTrigger = '<tab>'
        let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
        let g:tex_flavors='latex'
        let g:vimtex_view_method='zathura'
        let g:vimtex_view_general_viewer = 'zathura'
        let g:vimtex_quickfix_mode=0
        let g:lightline = {
          \ 'colorscheme': 'catppuccin',
          \ }
        hi Normal guibg=NONE ctermbg=NONE
        set conceallevel=1
        nmap <F6> :NERDTreeToggle<CR>   
        nmap <C-z> :tabprev<CR>
        nmap <C-x> :tabnext<CR>
      '';
    };
  };

  home.file.".config/nvim/UltiSnips/tex.snippets".source = ./nvim/UltiSnips/tex.snippets;
}
