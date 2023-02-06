#
# General Home-manager config
#
# flake.nix 
#   ├─ home.nix *
#   └─ ./modules   
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
    [(import ./modules/desktop/hyprland/home.nix)] ++
    (import ./modules/programs) ++
    (import ./modules/editors) ++
    (import ./modules/services);

  home.packages = with pkgs; [
      # Terminal
      btop
      pfetch
      nitch
      ranger
      cbonsai
      cmatrix
      foot

      # Video/Audio
      feh
      mpv
      pavucontrol
      vlc
      stremio

      # Apps
      firefox
      inkscape
      vscode-with-extensions

      # File Management
      pcmanfm
      unzip 
      unrar
      zip

      # LaTeX (band-aid)
      texlive.combined.scheme-full
  ];

  programs = {
    emacs.enable = true;
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

    flameshot = {
      enable = true;
      settings = {
         General = {
	    disabledTrayIcon = false;
	    startupLaunch = true;
	 };
      };
    };

    polybar = {
      enable = true;
      script = ''
      '';
      config = ./modules/services/polybar/config.ini;
    };
  };

  gtk = {
    enable = true;
    theme = {
      # name = "Dracula";
      # name = "Catppuccin-Dark";
      # package = pkgs.dracula-theme;
      # package = pkgs.catppuccin-gtk;
      name = "WhiteSur";
      package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      # name = "Papirus-Dark";
      # package = pkgs.papirus-icon-theme;
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };
    font = {
      # name = "JetBrains Mono Medium";
      name = "Roboto Mono Medium";
      # name = "FiraCode Nerd Font Mono Medium";
    };
  };
}
