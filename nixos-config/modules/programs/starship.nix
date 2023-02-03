{ config, lib, pkgs, ... }:

{
  programs = {
    starship = {
      enable = true;
      settings = {
      	add_newline = false;
	format = lib.concatStrings [
	 "$username"
	 "$hostname"
	 "$directory"
	 "$time"
         "$line_break"
         "$character"
	 # ''
# [┌────────────────────────────────](bold purple)
# [│](bold purple)$directory$rust$package
# [└─λ➜](bold purple)''
        ];
	character = {
          success_symbol = "[  λ](bold purple)";
        };
	directory = {
          format = "[ $path ]($style)";
	};
	time = {
          disabled = false;
	  time_format = "%R"; # Hour:Minute Format
	};
      };
    };
  };
}
