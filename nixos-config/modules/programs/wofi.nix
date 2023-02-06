#
# App launcher and system menu
#

{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      wofi
    ];

    # dotfiles
    file.".config/wofi/config".source = ./wofi/config;
    file.".config/wofi/style.css".source = ./wofi/style.css;
    file.".config/wofi/wifimenu.sh".source = ./wofi/wifimenu.sh;
    file.".config/wofi/powermenu.sh".source = ./wofi/powermenu.sh;
  };
}
