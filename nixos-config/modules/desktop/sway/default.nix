{ config, lib, pkgs, ... }:

{
  # imports = [ ../../programs/sway_waybar.nix ];

  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        autotiling
      ];
    };
  };
}
