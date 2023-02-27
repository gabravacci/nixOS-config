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

{ config, lib, pkgs, ... }:

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
    [(import ./git.nix)] ++
    [(import ./modules/desktop/hyprland/home.nix)] ++
    [(import ./modules/programming.nix)] ++
    (import ./modules/programs) ++
    (import ./modules/editors) ++
    (import ./modules/services);

  home.packages = with pkgs; [
      # Terminal
      asciiquarium
      btop
      htop
      cbonsai
      cmatrix
      fzf
      pfetch
      nitch
      ranger
      starfetch

      # Video/Audio
      feh
      ffmpeg
      lsix
      obs-studio
      mpv
      pavucontrol
      stremio
      youtube-dl

      # Apps
      amberol
      brave
      firefox
      google-chrome
      hugo
      inkscape
      logseq
      via
      
      # File Management
      font-manager
      okular
      popsicle
      cinnamon.nemo
      unzip 
      unrar
      zip

      # LaTeX (sorry!)
      texlive.combined.scheme-full
  ];

  programs = {
    zathura = {
      enable = true;

      extraConfig = ''
        map r reload

        set default-bg "#10151a"

        set recolor-lightcolor "#10151a"'';
    };
  };

  services = {
    network-manager-applet.enable = true;  # Network
    blueman-applet.enable = true;

    polybar = {
      enable = true;
      script = ''
      '';
      config = ./modules/services/polybar/config.ini;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    #name = "Dracula-cursors";
    #package = pkgs.dracula-theme;
    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    # name = "Catppuccin-Latte-Light-Cursors";
    # package = pkgs.catppuccin-cursors.latteLight;
    #name = "WhiteSur-cursors";
    #package = pkgs.whitesur-gtk-theme;
    size = 32;
  };

  gtk = {
    enable = true;
    theme = {
      # name = "Dracula";
      # package = pkgs.dracula-theme;
      # name = "Nord";
      # package = pkgs.nordic;
      name = "Catppuccin-Dark";
      package = pkgs.catppuccin-gtk;
      #name = "WhiteSur";
      #package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      #name = "Papirus-Dark";
      #package = pkgs.papirus-icon-theme;
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };
    font = {
      # name = "JetBrains Mono Medium";
      # name = "Roboto Mono Medium";
      name = "Roboto Light Medium";
      # name = "FiraCode Nerd Font Mono Medium";
    };
  };
}
