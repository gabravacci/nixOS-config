#
# Terminal 
#

{ config, lib, pkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;

      settings = {
        colors = {
          primary = {
            background = "#1a1e2a";      # 1e1e1e | 061115 | 282a36
            foreground = "#ffffff";      # dbd3c8 | d9d7d6 | f8f8f2
            # dim_foreground = "#a5abb6";
          };
          normal = {
           black= "#1d2430";
           red= "#ff5555";
           green= "#00fbad";
           yellow= "#ffdf5f";
           blue= "#5eadfc";
           magenta = "#fa5ead";
           cyan = "#8be9fd";
           white = "#ffffff";
          };
          # ?
          # normal = {
           #  black= "#484e5b";
           # red= "#f16269";
           # green= "#8cd7aa";
           # yellow= "#e9967e";
           # blue= "#79aaeb";
           # magenta = "#78b892";
           # cyan = "#7acfe4";
           # white = "#e5e5e5";
          # };
          # DRACULA
          #normal = {
           #black= "#000000";
           #red= "#ff5555";
           #green= "#50fa7b";
           #yellow= "#f1fa8c";
           #blue= "#bd93f9";
           #magenta = "#ff79c6";
           #cyan = "#8be9fd";
           #white = "#bfbfbf";
          #};
        };
        window = {
          # opacity = 1;
          dimensions = {
            columns = 82;
            lines = 25;
          };
          padding = {
            x = 24;
            y = 12;
          };

        decorations = "full";
        startup_mode = "Windowed";
        };
        font = { 
          size = 12;

          #normal.family = "Roboto Mono";
          #bold.family = "Roboto Mono";
          #italic.family = "Roboto Mono";
          normal.family = "FiraCode Nerd Font Mono";
          bold.family = "FiraCode Nerd Font Mono";
          italic.family = "FiraCode Nerd Font Mono";
          # normal.family = "Iosevka Nerd Font";
          # bold.family = "Iosevka Nerd Font";
          # italic.family = "Iosevka Nerd Font";
        };
      };
    };
  };
}
