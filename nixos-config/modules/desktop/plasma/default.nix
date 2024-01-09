{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;

      layout = "us";
      xkbVariant = "";
      libinput.enable = true;

      desktopManager.plasma5.enable = true;
    };
  };
}
