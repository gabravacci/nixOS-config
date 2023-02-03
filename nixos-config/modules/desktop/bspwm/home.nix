# bspwm config

{ config, lib, pkgs, ... }:

{
  xsession = {
    enable = true;
    windowManager = {
      bspwm = {
        enable = true;
        rules = {
          "Pcmanfm" = {
            state = "floating";
          };
        };
        extraConfig = ''
    bspc config border_width      2
    bspc config window_gaps      25
    bspc config split_ratio     0.52

    bspc monitor -d 1 2 3 4 5

    bspc config click_to_focus            true
    bspc config focus_follows_pointer     false
    bspc config borderless_monocle        false
    bspc config gapless_monocle           false

    bspc config normal_border_color  "#000000"
    bspc config focused_border_color "#cba6f7"

    #pgrep -x sxhkd > /dev/null || sxhkd &  # Not needed on NixOS

    feh --bg-tile $HOME/.config/wall        # Wallpaper

    killall -q polybar &                    # Reboot polybar to correctly show workspaces
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1;done 
    polybar main & #2>~/log &               # To lazy to figure out systemd service order
        '';
      };
    };
  };
}
