#
# Terminal emulator (for wayland)
#

{ config, lib, pkgs, ... }:

{
  programs = {
    foot = {
      enable = true;

      settings = {
        main = {
          term = "xterm-256color";

          font = "Terminus:size=8";
          dpi-aware = "yes";

          pad = "64x24";
        };

        colors = {
          background = "282a36";
          foreground = "f8f8f2";

          regular0 = "000000";  # black
          regular1 = "ff5555";  # red
          regular2 = "50fa7b";  # green
          regular3 = "f1fa8c";  # yellow
          regular4 = "bd93f9";  # blue
          regular5 = "ff79c6";  # magenta
          regular6 = "8be9fd";  # cyan
          regular7 = "bfbfbf";  # white
        };
      };
    };
  };
}
