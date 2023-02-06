#
# Hyprland config
#

{ config, lib, pkgs, ... }:
let
  hyprlandConf = ''
    monitor=,preferred,auto,1

    general {
      #main_mod=SUPER
      border_size = 2
      gaps_in = 0
      gaps_out = 3
      col.active_border=rgb(a7c7e7)
      col.inactive_border=rgb(000000)
      layout=master # master | dwindle
    }

    input {
      touchpad {
        natural_scroll = yes
      }
    }

    decoration {
      rounding=3
      multisample_edges=true
      active_opacity=1
      inactive_opacity=0.93
      fullscreen_opacity=1
      blur=no
      drop_shadow=true
    }
    
    # Mathhias animations
    #animations {
    #  enabled=true
    #  bezier = myBezier,0.1,0.7,0.1,1.05
    #  animation=fade,1,7,default
    #  animation=windows,1,7,myBezier
    #  animation=windowsOut,1,3,default,popin 60%
    #  animation=windowsMove,1,7,myBezier
    #}

    animations {
      enabled=1
      bezier = overshot, 0.13, 0.99, 0.29, 1.1
      animation = windows, 1, 4, overshot, slide
      animation = windowsOut, 1, 5, default, popin 80%
      animation = border, 1, 5, default
      animation = fade, 1, 8, default
      animation = workspaces, 1, 6, overshot, slidevert
    }

    gestures {
      workspace_swipe=true
      workspace_swipe_fingers=3
      workspace_swipe_distance=100
    }

    debug {
      damage_tracking=2
    }

    bindm=SUPER,mouse:272,movewindow
    bindm=SUPER,mouse:273,resizewindow

    bind=SUPER,Return,exec,${pkgs.alacritty}/bin/alacritty
    bind=SUPER,Q,killactive,
    bind=SUPER,Escape,exec,~/.config/wofi/powermenu.sh
    bind=SUPER,E,exec,${pkgs.pcmanfm}/bin/pcmanfm
    bind=SUPER,H,togglefloating,
    bind=SUPER,Space,exec,wofi --show drun --columns 2 -I -s ~/.config/wofi/style.css 
    bind=SUPER,P,pseudo,
    bind=SUPER,F,fullscreen,
    bind=SUPER,R,forcerendererreload

    bind=SUPER,left,movefocus,l
    bind=SUPER,right,movefocus,r
    bind=SUPER,up,movefocus,u
    bind=SUPER,down,movefocus,d
    
    bind=SUPERSHIFT,left,movewindow,l
    bind=SUPERSHIFT,right,movewindow,r
    bind=SUPERSHIFT,up,movewindow,u
    bind=SUPERSHIFT,down,movewindow,d

    bind=ALT,1,workspace,1
    bind=ALT,2,workspace,2
    bind=ALT,3,workspace,3
    bind=ALT,4,workspace,4
    bind=ALT,5,workspace,5
    bind=ALT,6,workspace,6
    bind=ALT,7,workspace,7
    bind=ALT,8,workspace,8
    bind=ALT,9,workspace,9
    bind=ALT,0,workspace,10
    bind=ALT,right,workspace,+1
    bind=ALT,left,workspace,-1

    bind=ALTSHIFT,1,movetoworkspace,1
    bind=ALTSHIFT,2,movetoworkspace,2
    bind=ALTSHIFT,3,movetoworkspace,3
    bind=ALTSHIFT,4,movetoworkspace,4
    bind=ALTSHIFT,5,movetoworkspace,5
    bind=ALTSHIFT,6,movetoworkspace,6
    bind=ALTSHIFT,7,movetoworkspace,7
    bind=ALTSHIFT,8,movetoworkspace,8
    bind=ALTSHIFT,9,movetoworkspace,9
    bind=ALTSHIFT,0,movetoworkspace,10
    bind=ALTSHIFT,right,movetoworkspace,+1
    bind=ALTSHIFT,left,movetoworkspace,-1

    bind=CTRL,right,resizeactive,20 0
    bind=CTRL,left,resizeactive,-20 0
    bind=CTRL,up,resizeactive,0 -20
    bind=CTRL,down,resizeactive,0 20

    # Waybar Toggle
    bind=SUPER,O,exec,killall -SIGUSR1 .waybar-wrapped

    # Volume, brightness, media control
    bind=,XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer -d 10
    bind=,XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer -i 10
    bind=,XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer -t
    bind=,XF86AudioMicMute,exec,${pkgs.pamixer}/bin/pamixer --default-source -t
    bind=,XF86MonBrightnessDown,exec,${pkgs.light}/bin/light -U 10
    bind=,XF86MonBrightnessUP,exec,${pkgs.light}/bin/light -A 10 

    bind=,print,exec,${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f - -o ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png && notify-send "Saved to ~/Pictures/$(date +%Hh_%Mm_%Ss_%d_%B_%Y).png"

    windowrule=float,^(Rofi)$

    # Auto start
    exec-once = ${pkgs.waybar}/bin/waybar &
    exec-once=${pkgs.swaybg}/bin/swaybg -m center -i $HOME/Pictures/dark-simple.png
    exec-once=${pkgs.networkmanagerapplet}/bin/nm-applet --indicator
    exec-once=${pkgs.blueman}/bin/blueman-applet
  '';
in
{
  home = {
    packages = with pkgs; [
      swaybg
      pamixer
    ];
  };
  xdg.configFile."hypr/hyprland.conf".text = hyprlandConf;
}
