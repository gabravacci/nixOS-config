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
            background = "#1e1e1e";
            foreground = "#dbd3c8";
            dim_foreground = "#a5abb6";
          };
          normal = {
            black= "#3b4252";
            red= "#bf616a";
            green= "#a3be8c";
            yellow= "#ebcb8b";
            blue= "#81a1c1";
            #magenta= "#96908a";
            magenta = "#a7c7e7";
            cyan = "#96908a";
            white = "#e5e9f0";
          };
        };
        window = {
          # opacity = 1;
          dimensions = {
            columns = 82;
            lines = 25;
          };
          padding = {
            x = 36;
            y = 36;
          };
        decorations = "full";
        startup_mode = "Windowed";
        };
        font = { 
          size = 14;

          normal.family = "Roboto Mono";
          bold.family = "Roboto Mono";
          italic.family = "Roboto Mono";
        };
      };
    };
  };
}
