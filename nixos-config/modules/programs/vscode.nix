{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      catppuccin.catppuccin-vsc
      github.copilot
      ms-python.python
      ms-vscode.cpptools
      sumneko.lua
      xaver.clang-format
    ];
  };
}

