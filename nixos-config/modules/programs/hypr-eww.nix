{ config, pkgs, inputs, lib, ... }:

let
  dependencies = with pkgs;
    [
      brightnessctl
      pamixer
      coreutils
    ];

  ewwYuck = pkgs.writeText "eww.yuck" (''
;; declare variables
(defpoll clock :interval "1s"
  `date "+%a %b %d %I:%M %p"`)

(deflisten workspaces :initial "[]" "bash /home/gabe/eww/left/scripts/get-workspaces")
(deflisten current_workspace :initial "1" "bash /home/gabe/eww/left/scripts/get-active-workspace")

(deflisten volume-level
  :initial "50"
  "/home/gabe/scripts/volume")

(defwidget workspaces-original []
  (eventbox :onscroll "bash /home/gabe/eww/left/scripts/change-active-workspace {} ''${current_workspace}" :class "workspaces-widget"
    (box :space-evenly true
      (label :text "''${workspaces}''${current_workspace}" :visible false)
      (for workspace in workspaces
        (eventbox :onclick "hyprctl dispatch workspace ''${workspace.id}"
          (box :class "workspace-entry ''${workspace.id == current_workspace ? "current" : ""} ''${workspace.windows > 0 ? "occupied" : "empty"}"
            (label :text "''${workspace.id}")))))))

(defwidget workspaces []
  (eventbox :onscroll "bash /home/gabe/eww/left/scripts/change-active-workspace {} ''${current_workspace}" :class "workspaces-widget"
    (box :space-evenly true
      (label :text "''${workspaces}''${current_workspace}" :visible false)
      (for workspace in workspaces
        (eventbox :onclick "hyprctl dispatch workspace ''${workspace.id}"
          (box 
            (label
              :class "workspace-entry ''${workspace.id == current_workspace ? "workspace-current" : ""} ''${workspace.windows > 0 ? "workspace-occupied" : "workspace-empty"}"
              :text {" ''${workspace.id == current_workspace ? '' : workspace.windows > 0 ? '' : ''}"})))))))

(defwidget tags []
  (eventbox :onscroll "bash /home/gabe/eww/left/scripts/change-active-workspace {} ''${current_workspace}" :class "workspaces-widget"
    (box :space-evenly true
         :orientation "v"
         :halign "center"
      (label :text "''${workspaces}''${current_workspace}" :visible false)
      (for workspace in workspaces
        (eventbox :onclick "hyprctl dispatch workspace ''${workspace.id}"
          (box 
            (label
              :class "workspace-entry ''${workspace.id == current_workspace ? "workspace-current" : ""} ''${workspace.windows > 0 ? "workspace-occupied" : "workspace-empty"}"
              :text {" ''${workspace.id == current_workspace ? '' : workspace.windows > 0 ? '' : ''}"})))))))

(defwidget tagbar []
  (centerbox :orientation "v"
             :halign "center"
        (box :class "segment-top"
             :valign "start"
             :orientation "v"
          (tags))
        (box :class "segment-center"
             :valign "center"
             :orientation "v"
          )
        (box :class "segment-bottom"
             :valign "end"
             :orientation "v"
          (vnet)
          (getram)
          (volume)
          (battery) 
          )))

(defwindow sidebar
  :monitor 0
  :stacking "bottom"
  :geometry (geometry
              :height "100%"
              :anchor "left center")
  :exclusive true
  (tagbar))

(defwidget battery []
  (box
    (label :text "BAT" :class "txt-bat")
    (box :class "circular-icon"
      (circular-progress
        :class {
        EWW_BATTERY['BAT1'].status == 'Discharging'
          ? EWW_BATTERY['BAT1'].capacity <= 30 ? "orange"
          : EWW_BATTERY['BAT'].capacity <= 15 ? "red"
          : "normal"
        : "green"
        }
        :value {EWW_BATTERY['BAT1'].capacity}
        :thickness 2))))

(defwidget net []
  (box :class "net"
       :orientation "h"
       :space-evenly false
       ;; :halign "end"
       :spacing 10
    (button
        :class ""
	:onclick "/home/gabe/scripts/wifimenu.sh"
        network)
))

(defwidget vnet []
  (box :class "net"
       :orientation "v"
       :space-evenly false
       :spacing 10
    (button
        :class ""
	:onclick "/home/gabe/scripts/wifimenu.sh"
        network)
))

(defpoll network :interval "1s"
  "/home/gabe/scripts/network.sh")
        
(defwidget volume []
  (box
    (label :text "VOL" :class "txt-vol")
    (box :class "circular-icon"
      (circular-progress
        :class {
        volume-level == 99 ? "red"
        : "green"
        }
        :value {
        volume-level == 99 ? 100
        : volume-level
        }
        :thickness 2))))

(defwidget getram []
 (box 
   (label :text "RAM" :class "txt-ram")
   (box :class "circular-icon"
     (circular-progress
       :class {
       EWW_RAM.used_mem_perc > 80 ? "red"
       : EWW_RAM.used_mem_perc > 60 ? "orange"
       : EWW_RAM.used_mem_perc > 40 ? "yellow"
       : EWW_RAM.used_mem_perc > 20 ? "blue"
       : "green"
       }
       :value {EWW_RAM.used_mem_perc}
       :start-at 75
       :thickness 2))))

(defwidget left []
  (box :orientation "h" :space-evenly false :spacing 10
       (workspaces)))

(defwidget center []
  (box :orientation "h" :space-evenly false :spacing 10 :halign "center"
       (label :text clock :class "clock")))

(defwidget right []
  (box :orientation "h" :space-evenly false :spacing 10 :halign "end" 
       (getram)
       (battery)
       (volume)
       (net)))

(defwindow bar
           :monitor 0
           :geometry (geometry :x "0%"
                               :y "2px"
                               :width "99%"
                               :anchor "top center")
           :stacking "fg"
           :exclusive true
           :windowtype "dock"
           :wm-ignore false
  (centerbox
    :class "container"
    :orientation "h"
    (left)
    (center)
    (right)))
  '');

  ewwScss = pkgs.writeText "eww.scss" (''
$white: #ffffff;
$default: #b3cfa7;
$blue: #82abbc;
$green: #4af04e;
$red: #ea5252;
$background: #31363b;

* {
  all: unset;
  color: $white;
  font-family: RobotoMono Nerd Font;
  font-weight: lighter;
  font-size: 16px;
}

.container {
  padding: 4px 8px;
  background-color: rgba(42, 47, 51, 0.8);
  border-bottom-right-radius: 10px;
  border-bottom-left-radius: 10px;
  border-top-right-radius: 10px;
  border-top-left-radius: 10px; 
  box-shadow: 2px 2px 2px rgba(#000000, 0.3);
}          

.net,
.clock,
.txt-bat,
.txt-vol,
.txt-ram {
  font-weight: 500;
  margin-bottom: 2px;
  padding: 0 5px;
}

.normal {
  color: $white;
}

.red {
  color: $red;
}

.orange {
  color: orange;
}

.green {
  color: $green;
}

.workspace-entry {
  padding: 0 5px;
}

.workspace-occupied {
  color: #acb765;
}

.workspace-current {
  color: $white;
} 
  '');

  ewwConf = pkgs.linkFarm "ewwConf" [
    {
      name = "eww.scss";
      path = ewwScss;
    }
    {
      name = "eww.yuck";
      path = ewwYuck;
    }
  ];
in
{
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ewwConf;
  };
  systemd.user.services.eww = {
    Unit = {
      Description = "Eww daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath dependencies}";
      ExecStart = "${config.programs.eww.package}/bin/eww daemon --no-daemonize";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
