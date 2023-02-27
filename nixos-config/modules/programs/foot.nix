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

          font = "FiraCode Nerd Font Mono:size=7";
          dpi-aware = "yes";

          pad = "52x24";
        };

        colors = {
          background = "1f2024";
          foreground = "ffffff";

          regular0 = "1d2430";  # black
          regular1 = "ff5555";  # red
          regular2 = "00fbad";  # green
          regular3 = "ffdf5f";  # yellow
          regular4 = "5eadfc";  # blue
          regular5 = "fa5ead";  # magenta
          regular6 = "8be9fd";  # cyan
          regular7 = "ffffff";  # white
        };
        # DARK SCHEMA
        # background = "c5c5c5";
        # foreground = "1f2024";
        #
        # regular0 = "222827";  # black
        # regular1 = "e1c1ee";  # red
        # regular2 = "5b94ab";  # green
        # regular3 = "cfcf9c";  # yellow
        # regular4 = "616c96";  # blue
        # regular5 = "a6c1e0";  # magenta
        # regular6 = "6e7899";  # cyan
        # regular7 = "c5c5c5";  # white
      };
    };
  };
}
