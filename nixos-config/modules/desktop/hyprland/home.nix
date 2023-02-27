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
      gaps_in = 5
      gaps_out = 7
      col.active_border=0xFF6a6f87
      col.inactive_border=rgb(000000)
      layout=dwindle # master | dwindle
    }

    input {
      touchpad {
        natural_scroll = yes
      }
    }

    decoration {
      rounding=0
      multisample_edges=true
      active_opacity=1
      inactive_opacity=0.87
      fullscreen_opacity=1

      blur=true 
      blur_size=4
      blur_passes=4
      blur_new_optimizations = true
      blur_xray = true
      blur_ignore_opacity = true

      drop_shadow = true
      shadow_ignore_window = true
      shadow_offset = 4 4
      shadow_range = 4
      shadow_render_power = 2
      col.shadow = 0x66000000
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
      bezier = overshot, 0.05, 0.9, 0.1, 1.05
      animation = windows, 1, 4, overshot, slide
      animation = windowsOut, 1, 4, default, slide
      animation = border, 1, 10, default
      animation = fade, 1, 8, default
      animation = workspaces, 1, 6, default, slidevert
    }

    gestures {
      workspace_swipe=true
      workspace_swipe_fingers=3
      workspace_swipe_distance=100
    }

    misc {
      disable_hyprland_logo=true

      focus_on_activate=true
    }

    debug {
      damage_tracking=2
    }

    bindm=SUPER,mouse:272,movewindow
    bindm=SUPER,mouse:273,resizewindow

    bind=SUPER,Return,exec,${pkgs.foot}/bin/foot
    bind=SUPER,Q,killactive,
    bind=SUPER,Escape,exec,~/.config/wofi/powermenu.sh
    # bind=SUPER,E,exec,${pkgs.pcmanfm}/bin/pcmanfm
    bind=SUPER,E,exec,${pkgs.cinnamon.nemo}/bin/nemo
    # bind=SUPER,E,exec,${pkgs.gnome.nautilus}/bin/nautilus
    bind=SUPER,T,togglefloating,
    bind=SUPER,Space,exec,wofi --show drun --columns 1 -I -s ~/.config/wofi/style.css 
    bind=SUPER,P,pseudo,
    bind=SUPER,F,fullscreen,
    bind=SUPER,R,forcerendererreload

    #bind=SUPER,left,movefocus,l
    #bind=SUPER,right,movefocus,r
    #bind=SUPER,up,movefocus,u
    #bind=SUPER,down,movefocus,d
    
    # Vim keybindings
    bind=SUPER,H,movefocus,l
    bind=SUPER,L,movefocus,r
    bind=SUPER,K,movefocus,u
    bind=SUPER,J,movefocus,d

    bind=SUPERSHIFT,H,movewindow,l
    bind=SUPERSHIFT,L,movewindow,r
    bind=SUPERSHIFT,K,movewindow,u
    bind=SUPERSHIFT,J,movewindow,d

    bind=SUPER,1,workspace,1
    bind=SUPER,2,workspace,2
    bind=SUPER,3,workspace,3
    bind=SUPER,4,workspace,4
    bind=SUPER,5,workspace,5
    bind=SUPER,6,workspace,6
    bind=SUPER,7,workspace,7
    bind=SUPER,8,workspace,8
    bind=SUPER,9,workspace,9
    bind=SUPER,0,workspace,10
    bind=SUPER,right,workspace,+1
    bind=SUPER,left,workspace,-1

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

    bind=CTRL,RIGHT,resizeactive,20 0
    bind=CTRL,LEFT,resizeactive,-20 0
    bind=CTRL,UP,resizeactive,0 -20
    bind=CTRL,DOWN,resizeactive,0 20

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

    windowrule=float,^(pavucontrol)$
    windowrule=float,^(blueman-manager)$
    # windowrule=float,^(pcmanfm)$
    windowrule=float,^(nemo)$
    #windowrule=float,^(files)$
    windowrulev2 = float, class:^(firefox)$, title:^(Firefox — Sharing Indicator)$
    windowrule=float,^(wofi)$

    # Auto start
    exec-once = ${pkgs.waybar}/bin/waybar &
    # exec-once=${pkgs.swaybg}/bin/swaybg -m center -i $HOME/Pictures/ocean.png
    exec-once=cd /home/gabe/nixos-config/modules/desktop/hyprland/ && ./random_wallpapers.sh
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
