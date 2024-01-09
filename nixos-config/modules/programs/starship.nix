{ config, lib, pkgs, ... }:

{
  programs = {
    starship = {
      enable = true;
      settings = {
      	add_newline = false;
# 	      format = lib.concatStrings [
# ''[╭─](white)$directory$time $git_branch$git_commit$git_state$git_status$package$cmake$dart$dotnet$premake$golang$java$kotlin$nodejs$perl$php$python$ruby$rust
# [╰──](white) ''
#         ];
# 	      format = lib.concatStrings [
# ''[╭─](white)$directory[](bg:#C3E88D fg:#82AAFF)$c$python$rust$elixir$golang$haskell[](fg:#C3E88D) 
# [╰──](white) ''
        # ];
# 	      format = lib.concatStrings [
# ''[](white)$directory[](white)
# [╰──](white)''
#         ];
	      format = lib.concatStrings [
''$directory$nix_shell 
$username ''
        ];

        directory = {
          #  i ﬦ--⟨⟩ α-λ-∗-   ∀ → ⊃ ⟶ Ψ/ψ    
          # format = "[](white)[ $path ](blue)[](white)";
          format = ''[\[](white)[$path](blue)[\]](white)'';
          truncation_symbol = "../";
          truncation_length = 3;
          truncate_to_repo = false;
        };

	      # directory = {
       #    # format = "[<](white)[$path](bold blue)[>](white)";
       #    style = "bg:#82AAFF fg:#1F2024";
       #    format = "[ $path ]($style)";
       #    truncation_symbol = "";
       #    truncation_length = 3;
       #    truncate_to_repo=false;
	      # };

	      time = {
          disabled = true;
          format = "[at $time](white)";
	        time_format = "%T"; 
	      };
        username = {
          disabled = false;
          show_always = true;
          style_user = "white"; 
          format = "[λ]($style)";
        };
        character = {
          success_symbol = "[>](green)[>](bold blue)[>](green)";
          error_symbol = "[>](red)[>](bold yellow)[>](red)";
        };
        c = {
          symbol = " ";
          style = "bg:#c3e88d fg:#1F2024";
          format = "[ $symbol ]($style)";
        };
        elixir = {
          symbol = " ";
          style = "bg:#c3e88d fg:#1F2024";
          format = "[ $symbol ]($style)";
        };
        golang = {
          symbol = " ";
          style = "bg:#c3e88d fg:#1F2024";
          format = "[ $symbol ]($style)";
        };
        haskell = {
          symbol = " ";
          style = "bg:#c3e88d fg:#1F2024";
          format = "[ $symbol ]($style)";
        };
        python = {
          symbol = " ";
          style = "bg:#c3e88d fg:#1F2024";
          format = "[ $symbol ]($style)";
        };
        rust = {
          symbol = " ";
          style = "bg:#c3e88d fg:#1F2024";
          format = "[ $symbol ]($style)";
        };

        nix_shell = {
          symbol = " ";
          # style = "bg:#c3e88d fg:#1F2024";
          style = "green";
          format = ''--[\[](white)[$symbol]($style)[\]](white)'';
        };
      };
    };
  };
}

