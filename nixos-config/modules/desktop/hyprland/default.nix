{ config, lib, pkgs, ... }:

{
  imports = [ ../../programs/min_waybar.nix ];

  services.xserver = {
    enable = true;

    layout = "us";
    xkbVariant = "";
    libinput.enable = true;

    displayManager.gdm = {
      enable = true;
    };
  };

  environment = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };

    systemPackages = with pkgs; [
      grim
      mpvpaper
      slurp
      swappy
      wl-clipboard
      wlr-randr
    ];
  };

  programs.hyprland.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
