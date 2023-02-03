#
# Terminal 
#

{ config, lib, pkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;

      settings = {
        window = {
          # opacity = 1;
          dimensions = {
            columns = 110;
            lines = 30;
          };
        decorations = "full";
        startup_mode = "Windowed";
        };
        font.size = 12;
      };
    };
  };
}
