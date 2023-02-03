{ config, lib, pkgs, ... }:

{
  services = {
    dbus = {
      enable = true;
    };

    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";

      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = false;
        };
      };

      displayManager = {
        lightdm = {
          enable = true;
          background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
          greeters = {
            gtk.theme = {
              name = "Dracula";
              package = pkgs.dracula-theme;
            };
            gtk.cursorTheme = {
              name = "Dracula-cursors";
              package = pkgs.dracula-theme;
              size = 16;
            };
          };
        };
      };
      windowManager.bspwm = {
        enable = true;
      };
    };
  };
}
