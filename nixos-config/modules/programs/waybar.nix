#
# Status/general bar
#

{ config, lib, pkgs, ... }:

let
  user = "gabe";
in
{
  environment.systemPackages = with pkgs; [
    waybar
  ];

  nixpkgs.overlays = [                                      # Waybar needs to be compiled with the experimental flag for wlr/workspaces to work
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        patchPhase = ''
          substituteInPlace src/modules/wlr/workspace_manager.cpp --replace "zext_workspace_handle_v1_activate(workspace_handle_);" "const std::string command = \"hyprctl dispatch workspace \" + name_; system(command.c_str());"
        '';
      });
    })
  ];

  home-manager.users.${user} = {
    programs.waybar = {
      enable = true;
      # Will it start automatically?
      systemd = {
        enable = true;
      };
      style = ''
        * {
          border: none;
          font-family: "Roboto Light";
          font-size: 14pt;
          text-shadow: 0px 0px 5px #000000;
        }
        button:hover {
          background-color: rgba(80,100,100,0.4);
        }
        window#waybar {
          background-color: rgba(0,0,0,0.5);
          /*background: transparent;*/
          transition-property: background-color;
          transition-duration: .5s;
          /*border-bottom: none;*/
        }
        window#waybar.hidden {
          opacity: 0.2;
        }
        #workspace,
        #clock,
        #network,
        #window,
        #pulseaudio,
        #battery,
        #custom-menu {
          color: #A7C7E7;
          padding: 0px 7px 0px 7px;
        }
        #workspaces button {
          padding: 0px 5px;
          min-width: 5px;
          color: rgba(255,255,255,0.8);
        }
        #workspaces button:hover {
          background-color: rgba(0,0,0,0.2);
        }
        /*#workspaces button.focused {*/
        #workspaces button.active {
          color: rgba(255,255,255,0.8);
          background-color: rgba(80,100,100,0.4);
        }
        #workspaces button.visible {
          color: #ccffff;
        }
        #workspaces button.hidden {
          color: #999999;
        }
        #battery.warning {
          color: #ff5d17;
          background-color: rgba(0,0,0,0);
        }
        #battery.critical {
          color: #ff200c;
          background-color: rgba(0,0,0,0);
        }
        #battery.charging {
          color: #9ece6a;
          background-color: rgba(0,0,0,0);
        }
      '';
      settings = {
        Main = {
          layer = "top";
          position = "top";
          height = 16;
          modules-left = [ "custom/menu" "wlr/workspaces" ];
          modules-center = [ "hyprland/window" ];
          # modules-right = [ "network" "pulseaudio" "battery" "clock" ];
          modules-right = [ "battery" "pulseaudio" "network" "clock" ];
          "hyprland/window" = {
            format = "{}";
          };
          "wlr/workspaces" = {
            format = "{name}";
            #format = "<span font='12'>{icon}</span>";
            #format-icons = {
            #  "1"="";
            #  "2"="";
            #  "3"="";
            #  "4"="";
            #  "5"="";
            #  "6"="";
            #  "7"="";
            #  "8"="";
            #  "9"="";
            #  "10"="";
            #};
            #all-outputs = true;
            active-only = false;
            on-click = "activate";
          };
          "custom/menu" = {
            format = "<span font='16'>λ</span>";
            on-click = "bash ~/.config/wofi/powermenu.sh";
            tooltip = false;
          };
          clock = {
            format = "{:%b %d %H:%M}  ";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            #format-alt = "{:%A, %B %d, %Y} ";
          };

          cpu = {
            format = " {usage}% <span font='11'></span> ";
            interval = 1;
          };
          disk = {
            format = "{percentage_used}% <span font='11'></span>";
            path = "/";
            interval = 30;
          };
          memory = {
            format = "{}% <span font='11'></span>";
            interval = 1;
          };
          battery = {
            interval = 60;
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = " {capacity}%";
            format-icons = ["" "" "" "" ""]; # FiraCode icons
            #format-icons = [ "" "" "" "" "" ]; # JetBrains icons
            max-length = 25;
          };
          pulseaudio = {
            format = "{icon} {volume}% {format_source}";
            format-bluetooth = "{icon} {volume}% {format_source}";
            #format-bluetooth-muted = "<span font='12'>x</span> {volume}% {format_source} ";
            format-muted = "婢 {format_source}";
            #format-source = "{volume}% <span font='11'></span>";
            format-source = "";
            format-source-muted = "";
            format-icons = {
              # default = [ "" "" "" ];
              default = [ "󰕿" "󰖀" "󰕾" ];
              headphone = "";
              #hands-free = "";
              #headset = "";
              #phone = "";
              #portable = "";
              #car = "";
            };
            tooltip-format = "{desc}, {volume}%";
            on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
            on-click = "${pkgs.pamixer}/bin/pamixer -t";
          };
          network = {
            format-wifi = "<span font='20'></span>";
            format-ethernet = "<span font='12'></span>";
            #format-ethernet = "<span font='12'></span> {ifname}: {ipaddr}/{cidr}";
            format-linked = "<span font='12'>睊</span> {ifname} (No IP)";
            format-disconnected = "<span font='12'>睊</span> Not connected";
            #format-alt = "{ifname}: {ipaddr}/{cidr}";
            tooltip-format = "{essid} {ipaddr}/{cidr}";
            on-click-right = "${pkgs.alacritty}/bin/alacritty -e nmtui";
            on-click = "bash ~/.config/wofi/wifimenu.sh";
          };
        };
      };
    };
  };
}
