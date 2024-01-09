#
# General Home-manager config
#
# flake.nix 
#   ├─ home.nix *
#   └─ ./modules   
#        ├─ programming.nix
#        ├─ ./programs
#        │    └─ default.nix 
#        ├─ ./editors 
#        │    └─ default.nix
#        └─ ./services
#             └─ default.nix
#

{ inputs, config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "gabe";
  home.homeDirectory = "/home/gabe";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.starship.enable = true;

  # Module imports
  imports = 
    #[(import ./modules/desktop/bspwm/home.nix)] ++
    [(import ./modules/desktop/sway/home.nix)] ++
    [(import ./git.nix)] ++
    [(import ./modules/desktop/hyprland/home.nix)] ++
    [(import ./modules/programming.nix)] ++
    (import ./modules/programs) ++
    (import ./modules/editors) ++
    (import ./modules/services);

  home.packages = with pkgs; [
      # Terminal
      # asciiquarium
      # btop
      htop
      iftop
      # cbonsai
      # cmatrix
      fzf
      gum
      pfetch
      # nitch
      ranger
      starfetch

      # Video/Audio
      feh
      # ffmpeg
      lsix
      obs-studio
      mpv
      pavucontrol
      stremio
      youtube-dl     # Youtube video downloader
      yt-dlp         # extension for more websites

      # Apps
      # amberol        # Music Player
      brave
      firefox
      nyxt
      hugo
      geany
      inkscape
      obsidian
      # logseq
      # via
      
      # File Management
      font-manager
      okular
      pcmanfm
      stow
      p7zip
      unzip 
      unrar
      zip

      # LaTeX (sorry!)
      texlive.combined.scheme-full
      tectonic
  ];

  programs = {
    zathura = {
      enable = true;

      extraConfig = ''
        map r reload

        set default-bg "#10151a"

        set recolor-lightcolor "#161616"'';
    };
    # TODO: move this to its own module
    emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      extraPackages = (epkgs: (with epkgs; [
        olivetti
        ivy
        ivy-rich
        all-the-icons-ivy-rich
        lsp-mode
        lsp-ui
        treemacs
        evil-nerd-commenter
        nix-mode
        haskell-mode
        lsp-pyright
        lsp-java
        rust-mode
        web-mode
        cider
        sly
        slime
        company
        company-box 
        vterm
        projectile # git
        magit
        helpful
        which-key  
        rainbow-delimiters # for Lisp
        all-the-icons
        all-the-icons-dired
        doom-modeline
        nano-modeline
        org-fragtog
        org
        org-bullets
        org-appear
        imenu-list
        auctex
        engrave-faces
        counsel
        general
        evil
        evil-collection
        doom-themes
        acme-theme
        nano-theme
      ]));
    };
  };

  services = {
    # network-manager-applet.enable = true;  # Network
    blueman-applet.enable = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    # name = "Catppuccin-Mocha-Dark-Cursors";
    # package = pkgs.catppuccin-cursors.mochaDark;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    # name = "Catppuccin-Latte-Light-Cursors";
    # package = pkgs.catppuccin-cursors.latteLight;
    #name = "WhiteSur-cursors";
    #package = pkgs.whitesur-gtk-theme;
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      # name = "Dracula";
      # package = pkgs.dracula-theme;
      # name = "Skeu";
      # package = pkgs.skeu;
      # name = "Clearlooks-Phenix";
      # package = pkgs.clearlooks-phenix;
      # name = "TraditionalOk";   # Menta | TraditionalGreen | BlackMATE? |  
      # package = pkgs.mate.mate-themes;
      # name = "Gruvbox-Dark-B";
      # package = pkgs.gruvbox-gtk-theme;
      # name = "WhiteSur-Dark";
      # package = pkgs.whitesur-gtk-theme;
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;
    };
    iconTheme = {
      #name = "Papirus-Dark";
      #package = pkgs.papirus-icon-theme;
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };
    font = {
      name = "RobotoMono Nerd Font Light";
      # name = "Roboto Mono Medium";
      # name = "Roboto Light Medium";
    };
  };
}
