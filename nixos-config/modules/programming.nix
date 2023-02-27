{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
      # C
      gcc
      # clang
      clang-tools
      cmake

      # Clojure
      clojure

      # docker
      docker

      # elixir
      elixir
      elixir_ls

      # Go
      go
      gopls

      # Haskell
      cabal2nix
      ghc
      haskell-language-server
      haskellPackages.cabal-install
      haskellPackages.stack

      # JavaScript
      nodejs
      yarn

      # Lua
      lua
      sumneko-lua-language-server

      # Nix
      nil

      # Python
      (python3.withPackages (ps: with ps; [ setuptools pip debugpy python-lsp-server virtualenv ]))
      autoflake
      poetry
      python3Packages.ipython
      python3Packages.parso
      python3Packages.twine

      # Rust
      cargo
      perl
      rustc
      rust-analyzer
      rustfmt

      # Tex (LSP)
      texlab
  ];
}
