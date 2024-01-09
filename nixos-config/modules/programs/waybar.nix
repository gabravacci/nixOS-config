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
      # systemd = {
      #   enable = true;
      # };
      style = ''
        * {
          border: none;
          /* font-family: "RobotoMono Nerd Font"; */ 
          font-family: "Liga SFMono Nerd Font"; 
          font-weight: 300;
          font-size: 14pt;
          /* text-shadow: 0px 0px 5px #000000; */
        }
        window#waybar > box {
          background-color: #161616;
          transition-property: background-color;
          transition-duration: .5s;
          /*border-bottom: none;*/
        }
        window#waybar.hidden {
          opacity: 0.2;
        }
        
        #workspaces button {
          color: #FFFFFF;
        }

        #workspaces button.active {
          border-bottom: 2px solid #FFFFFF;
          border-radius: 0px;
        }

        #tray,
        #network,
        #window,
        #pulseaudio,
        #battery,
        #memory,
        #disk,
        #custom-menu {
          color: #FFFFFF;
          padding: 3px 15px 3px 15px;
          /* border-left: solid 1px #FFFFFF; */
        }

        #clock {
          color: #FFFFFF;
          padding: 3px 10px 3px 5px;
        }

        #cpu {
          color: #FFFFFF;
          padding: 3px 10px 3px 10px;
        }

        #custom-icon {
          color: #FFFFFF;
          padding: 3px 10px 3px 10px;
          border-right: solid 1px #FFFFFF;
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
          color: #1db954;
          background-color: rgba(0,0,0,0);
        }
      '';
      settings = {
        Main = {
          layer = "top";
          position = "top";
          # margin-left = 10;
          # margin-right = 10;

          height = 32;            # 0 | 16 | 30

          modules-left = [ "wlr/workspaces" "hyprland/submap" "hyprland/window" ];
          # modules-center = [ "hyprland/window" ];
          modules-right = [ "cpu" "memory" "disk" "battery" "pulseaudio" "tray" "clock" ];
          "hyprland/window" = {
            format = "{}";
          };
          "wlr/workspaces" = {
            # format = "{name}";
            format = "{icon}";
            format-icons = {
             # active = "";
             # default = "";
              "1" = "一";
              "2" = "二";
              "3" = "三";
              "4" = "四";
              "5" = "五";
              "6" = "六";
              "7" = "七";
              "8" = "八";
              "9" = "九";
              "10" = "";
            };
            active-only = false;
            on-click = "activate";
          };
          "custom/menu" = {
            format = "┃";
            tooltip = false;
          };
          "custom/icon" = {
            # format = "";
            # Cozette format
            format = "λ";
            tooltip = false;
          };
          clock = {
            format = "{:%a %b %d %I:%M %p}  ";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            #format-alt = "{:%A, %B %d, %Y} ";
          };
          cpu = {
            format = "CPU:{usage}%";
            interval = 1;
          };
          disk = {
            format = "<span color=\"#82aaff\">/</span> {percentage_used}%";
            path = "/";
            interval = 30;
          };
          memory = {
            format = "RAM: {}%";
            interval = 1;
          };
          tray = {
            icon-size = 25;
            tooltip = false;
            spacing = 10;
          };
          battery = {
            interval = 60;
            states = {
              warning = 30;
              critical = 15;
            };
            #     a    󰣨 
            # λ
            format = "{icon}  {capacity}%";
            format-charging = "{icon}  {capacity}%";
            format-icons = ["" "" "" "" ""]; # FiraCode icons
            #format-icons = [ "" "" "" "" "" 󱐋]; # JetBrains icons
            max-length = 25;
          };
          pulseaudio = {
            format = "{icon}";
            format-bluetooth = "{icon} ";
            # format-muted = "婢 ──✗──";
            format-muted = "婢"; 
            format-source = "";
            format-source-muted = "";
            format-icons = {
              # default = [ "󰕿 ─────" "󰕿 ━────" "󰖀 ━━───" "󰖀 ━━━──" "󰕾 ━━━━─" "󰕾 ━━━━━" ];
              # cozette version
              # default = [ "奄 ─────" "奄 ━────" "奔 ━━───" "奔 ━━━──" "墳 ━━━━─" "墳 ━━━━━" ];
              default = [ "奄"  "奔" "墳"];
              headphone = "";
            };
            tooltip-format = "{volume}%";
            on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
            on-click = "${pkgs.pamixer}/bin/pamixer -t";
          };
        };
      };
    };
  };
}
