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
            background = "#282a36";      # 1e1e1e | 061115
            foreground = "#f8f8f2";      # dbd3c8 | d9d7d6
            dim_foreground = "#a5abb6";
          };
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
          normal = {
           black= "#000000";
           red= "#ff5555";
           green= "#50fa7b";
           yellow= "#f1fa8c";
           blue= "#bd93f9";
           magenta = "#ff79c6";
           cyan = "#8be9fd";
           white = "#bfbfbf";
          };
        };
        window = {
          # opacity = 1;
          dimensions = {
            columns = 82;
            lines = 25;
          };
          padding = {
            x = 40;
            y = 12;
          };

        decorations = "full";
        startup_mode = "Windowed";
        };
        font = { 
          size = 14;

          #normal.family = "Roboto Mono";
          #bold.family = "Roboto Mono";
          #italic.family = "Roboto Mono";
          normal.family = "Roboto Mono";
          bold.family = "Roboto Mono";
          italic.family = "Roboto Mono";
        };
      };
    };
  };
}
