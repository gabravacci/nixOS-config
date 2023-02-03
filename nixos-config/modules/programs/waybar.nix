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
          font-family: FiraCode Nerd Font Mono;
          /*font-weight: bold;*/
          font-size: 12px;
          text-shadow: 0px 0px 5px #000000;
        }
        button:hover {
          background-color: rgba(80,100,100,0.4);
        }
        window#waybar {
          background-color: rgba(0,0,0,0.5);
          background: transparent;
          transition-property: background-color;
          transition-duration: .5s;
          border-bottom: none;
        }
        window#waybar.hidden {
          opacity: 0.2;
        }
        #workspace,
        #clock,
        #network,
        #network,
        #window,
        #battery,
        #custom-menu {
          color: #A7C7E7;
          padding: 0px 5px 0px 5px;
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

          modules-right = [ "network" "battery" "clock" ];

          "wlr/workspaces" = {
            format = "<span font='11'>{name}</span>";
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
            on-click = ''${pkgs.rofi}/bin/rofi -show power-menu -modi "power-menu:rofi-power-menu --choices=logout/suspend/reboot/shutdown"'';
            on-click-right = "${pkgs.rofi}/bin/rofi -show drun";
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
            format = "{capacity}% <span font='11'>{icon}</span>";
            format-charging = "{capacity}% <span font='11'></span>";
            format-icons = ["" "" "" "" ""];
            max-length = 25;
          };
          network = {
            format-wifi = "<span font='11'></span>";
            format-ethernet = "<span font='11'></span>";
            #format-ethernet = "<span font='11'></span> {ifname}: {ipaddr}/{cidr}";
            format-linked = "<span font='11'>睊</span> {ifname} (No IP)";
            format-disconnected = "<span font='11'>睊</span> Not connected";
            #format-alt = "{ifname}: {ipaddr}/{cidr}";
            tooltip-format = "{essid} {ipaddr}/{cidr}";
            on-click-right = "${pkgs.alacritty}/bin/alacritty -e nmtui";
          };
        };
      };
    };
  };
}
