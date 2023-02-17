{ config, lib, pkgs, ... }:

{
  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        autotiling
      ];
    };
  };
}
