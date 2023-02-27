{ config, lib, pkgs, inputs, ... }: 

{
  programs.helix = {
    enable = true;
    # package = inputs.helix.packages.${pkgs.system}.default;

    settings = {
      theme = "catppuccin_macchiato_transparent";
      keys.normal = {
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
        "X" = "extend_line_above";
        "esc" = ["collapse_selection" "keep_primary_selection"];
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        "C-d" = ["half_page_down" "align_view_center"];
        "C-u" = ["half_page_up" "align_view_center"];
        "C-q" = ":bc";
        space.u = {
          f = ":format"; # format using LSP formatter
          w = ":set whitespace.render all";
          W = ":set whitespace.render none";
        };
      };

      keys.select = {
        "%" = "match_brackets";
      };

      editor = {
        color-modes = true;
        cursorline = true;
        mouse = true;
        idle-timeout = 1;
        line-number = "relative";
        scrolloff = 5;
        bufferline = "always";
        true-color = true;
        lsp.display-messages = true;
        # rulers = [80];
        indent-guides = {
          render = true;
        };

        gutters = ["diagnostics" "line-numbers" "spacer" "diff"];

        statusline = {
          separator = "";
          left = ["mode" "selections" "spinner" "file-name" "total-line-numbers"];
          center = [];
          right = ["diagnostics" "file-encoding" "file-line-ending" "file-type" "position-percentage" "position"];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        whitespace.characters = {
          space = "·";
          nbsp = "⍽";
          tab = "→";
          newline = "⤶";
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "block";
        };
      };
    };

    # override catppuccin theme and remove background to fix transparency
    themes = {
      catppuccin_macchiato_transparent = {
        "inherits" = "catppuccin_macchiato";
        "ui.background" = "{}";
      };
    };

    languages = with pkgs; [
      {
        name = "rust";
        auto-format = true;
        language-server.command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
      }
    ];
  };
}
