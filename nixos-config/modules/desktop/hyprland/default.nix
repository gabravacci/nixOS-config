{ config, lib, pkgs, ... }:

{
  imports = [ ../../programs/waybar.nix ];

  services.xserver = {
    enable = true;

    layout = "us";
    xkbVariant = "";
    libinput.enable = true;

    displayManager.gdm = {
      enable = true;
    };
    # windowManager.jwm.enable=true;
    # windowManager.cwm.enable=true;
  };

  environment = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };

    systemPackages = with pkgs; [
      # X phase shit ------------
      # dmenu
      # st
      # xorg.xclock 
      # xlogo
      # nedit       # text editor
      # dillong     # browser
      # -------------------------
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
