#
# App launcher and system menu
#

{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      rofi-power-menu
#      rofi-wayland
    ];
  };

  programs = {
    rofi = {
      enable = true;
      terminal = "${pkgs.alacritty}/bin/alacritty";
      location = "center";
    };
  };
}
