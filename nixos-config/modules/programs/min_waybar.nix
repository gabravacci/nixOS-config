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
          border-radius: 0;
          font-family: Roboto;
          font-size: 16px;
          min-height: 0;
        }

        window#waybar {
          background: transparent;
        }

        .modules-center {
          background: #1d1f21;
          min-width: 100px;
          color: white;
          border-radius: 10px;
          margin-top: 10px;
          padding-left: 10px;
          padding-right: 10px;
        }

        .modules-right {
          background: #1d1f21;
          color: white;
          padding-right: 10px;
          padding-left: 10px;
          margin-right: 10px;
          margin-top: 10px;
          border-radius: 10px;
        }

        #battery {
          padding-left: 10px;
          padding-right: 10px;
        }

        #pulseaudio {
          padding-left: 10px;
          padding-right: 10px;
        }

        #tray {
          padding-left: 10px;
          padding-right: 10px;
        }

        #clock {
          padding-left: 10px;
          padding-right: 10px;
        }

        #workspaces {
          margin-top: 10px;
          margin-left: 10px;
          border-radius: 10px;
          background: #1d1f21;
        }

        #workspaces button {
          padding: 5px 10px;
          font-weight: 600;
          background: transparent;
          border-radius: 20%;
          color: white;
        }

        #workspaces button.active {
          background-color: #454545;
        }

        #workspaces button:hover {
          background-color: #bd93f9;
        }

        tooltip {
          background: rgba(43, 48, 59, 0.7);
          border: 1px solid rgba(100, 114, 125, 0.5);
        }
        tooltip label {
          color: white;
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

          height = 16;            # 0 | 16

          modules-left = [ "wlr/workspaces" ];
          modules-center = [ "hyprland/window" ];
          modules-right = [ "battery" "pulseaudio" "tray" "clock" ];
          "hyprland/window" = {
            format = "{}";
          };
          "wlr/workspaces" = {
            format = "{name}";
            active-only = false;
            on-click = "activate";
          };
          clock = {
            format = "{:%b %d %H:%M}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            #format-alt = "{:%A, %B %d, %Y} ";
          };

          tray = {
            icon-size = 22;
            tooltip = false;
            spacing = 3;
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
            format-muted = "婢 {format_source}";
            format-source = "";
            format-source-muted = "";
            format-icons = {
              #default = [ "🔈" "🔈" "🔊" ];
              default = [ "󰕿" "󰖀" "󰕾" ];
              headphone = "🎧";
            };
            tooltip-format = "{desc}, {volume}%";
            on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
            on-click = "${pkgs.pamixer}/bin/pamixer -t";
          };
        };
      };
    };
  };
}
