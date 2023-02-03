{ config, lib, pkgs, ... }:

{
  imports = [ ../../programs/waybar.nix ];

  programs.dconf.enable = true;

  services = {
    xserver = {
      enable = true;

      layout = "us";
      xkbVariant = "";
      libinput.enable = true;

      displayManager = {                          # Display Manager
        gdm = {
          enable = true;
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      grim
      mpvpaper
      slurp
      swappy
      wl-clipboard
      wlr-randr
    ];
  };

  programs = {
    hyprland = {
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable= true;
  };
}
