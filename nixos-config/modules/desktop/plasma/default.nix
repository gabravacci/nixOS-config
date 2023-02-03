#
#  Gnome config
#

{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

  services = {
    xserver = {
      enable = true;

      layout = "us";
      xkbVariant = "";
      libinput.enable = true;

      desktopManager= {
        plasma5 = {                                 # Window Manager
          enable = true;
        };
      };
    };
    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
    ];
  };

  programs.zsh.enable = true;                     # Weirdly needs to be added to have default user on lightdm

  hardware.pulseaudio.enable = false;
}
