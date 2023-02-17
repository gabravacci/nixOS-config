{ config, lib, pkgs, ... }:

{
  programs = {
    starship = {
      enable = true;
      settings = {
      	add_newline = false;
	format = lib.concatStrings [
         #"$username"
         #"$hostname"
         #"$directory"
         #"$time"
         #"$line_break"
         #"$character"
	 # ''
         "{$directory}"
         "$line_break"
         "$character"
# [┌────────────────────────────────](bold purple)
# [│](bold purple)$directory$rust$package
# [└─λ➜](bold purple)''
        ];
	character = {
          success_symbol = "[λ](bold purple)";
          error_symbol = "[λ](bold red)";
        };
	directory = {
          format = "[ $path ](white)";
          #format = "[]($style)[ ](bg:#24263a fg:#ECD3A0)[$path](bg:#24263a fg:#BBC3DF bold)[ ]($style)";
          #style = "bg:none fg:#24263a";
          truncation_length = 3;
          truncate_to_repo=false;
	};
	time = {
          disabled = false;
	  time_format = "%R"; # Hour:Minute Format
	};
      };
    };
  };
}
