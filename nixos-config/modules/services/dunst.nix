#
# Notification daemon
#

{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.libnotify ];  # Dependency
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus Dark";
      package = pkgs.papirus-icon-theme;
      size = "16x16";
    }; 
  };
}
