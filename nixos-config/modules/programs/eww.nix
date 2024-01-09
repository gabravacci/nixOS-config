{ config, pkgs, inputs, lib, ... }:
let
  dependencies = with pkgs;
    [
      brightnessctl
      pamixer
      coreutils
    ];

  ewwYuck = pkgs.writeText "eww.yuck" (''
    (defwidget bar []
      (centerbox :orientation "v"
                 :halign "center"
        (box :class "segment-top"
             :valign "start"
             :orientation "v"
          (tags))
        (box :class "segment-center"
             :valign "center"
             :orientation "v"
          (time)
          (date))
        (box :class "segment-bottom"
             :valign "end"
             :orientation "v"
          (menu)
          (wifi)
          (volume)
          (battery)
          (current-tag))))
    (defwidget time []
      (box :class "time"
           :orientation "v"
        hour min type))
    (defwidget date []
      (box :class "date"
           :orientation "v"
        year month day))
    (defwidget volume []
      (button :class "icon"
              :orientation "v"
        (circular-progress :value volume-level
                           :thickness 3)))

    (defwidget menu []
      (button :class "icon"
              :orientation "v"
              :onclick "''${EWW_CMD} open --toggle notifications-menu"
         ""))

    (defwidget wifi []
      (button :class "icon"
              :orientation "v"
         wifi))

    (defwidget battery []
      (button :class "icon"
              :orientation "v"
              :onclick ""
        (circular-progress :value "''${EWW_BATTERY['BAT1'].capacity}"
                           :thickness 3)))

    (defwidget current-tag []
      (button :class "current-tag"
              :orientation "v"
              :onclick "kickoff & disown"
        "''${active-tag}"))
    (defwidget tags []
        (box :class "tags"
             :orientation "v"
             :halign "center"
          (for tag in tags
            (box :class {active-tag == tag.tag ? "active" : "inactive"}
              (button :onclick "swaymsg workspace ''${tag.tag} ; ''${EWW_CMD} update active-tag=''${tag.tag}"
                "''${tag.label}")))))
      (defvar tags '[{ "tag": 1, "label": "一" },
                     { "tag": 2, "label": "二" },
                     { "tag": 3, "label": "三" },
                     { "tag": 4, "label": "四" },
                     { "tag": 5, "label": "五" },
                     { "tag": 6, "label": "六" },
                     { "tag": 7, "label": "七" },
                     { "tag": 8, "label": "八" },
                     { "tag": 9, "label": "九" },
                     { "tag": 0, "label": "" }]')

    (defvar active-tag "1")
    ;; variables
    (defpoll hour :interval "1m" "date +%I")
    (defpoll min  :interval "1m" "date +%M")
    (defpoll type :interval "1m" "date +%p")
    (defpoll day   :interval "10m" "date +%d")
    (defpoll month :interval "1h"  "date +%m")
    (defpoll year  :interval "1h"  "date +%y")

    ;; how to update with helper script
    ;; (defvar volume-level 33)
    (deflisten volume-level
      :initial "50"
      "/home/gabe/scripts/volume")

    (defpoll wifi :interval "3s"
             `/home/gabe/scripts/wifi.py`)

    ;; actual bar
    (defwindow bar
      :monitor 0
      :stacking "bottom"
      :geometry (geometry
                   :height "100%"
                   :anchor "left center")
      :exclusive true
      (bar))
  '');

  ewwScss = pkgs.writeText "eww.scss" (''
    $baseTR: rgba(13,13,13,0.13);
    $base00: #181818;
    $base01: #282828;
    $base04: #b8b8b8;
    $base06: #e8e8e8;
    $base0C: #86c1b9;
    $base0E: #ba8baf;

    * {
      all: unset;
    }
    window {
      font-family: "JetBrainsMono Nerd Font";
      font-size: 14px;
      background-color: rgba(0,0,0,0);
      color: $base04;
      & > * {
        margin: 0px 0px 12px 12px;
      }
    }
    .tags {
      margin-top: 9px;
    }
    .active {
      color: $base06;
      padding: 6px 9px 6px 6px;
      background-color: $baseTR;
      border-left: 3px solid $base0C;
    }
    .segment-center {
      margin-top: 18px;
      padding: 9px;
    }
    .time {
      color: $base06;
      font-weight: bold;
      margin-bottom: 6px;
    }
    .date {
      margin-top: 6px;
    }
    .icon {
      background-color: $base01;
      padding: 9px;
      margin: 4.5px 0px;
      border-radius: 3px;
    }
    .current-tag {
      color: $base00;
      background-color: $base0E;
      padding: 9px;
      margin: 4.5px 0px;
      border-radius: 3px;
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