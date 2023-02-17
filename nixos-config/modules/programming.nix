{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
      # C
      gcc

      # Haskell
      cabal2nix
      ghc
      haskellPackages.cabal-install
      haskellPackages.stack

      # Lua
      lua

      # Python
      (python3.withPackages (ps: with ps; [ setuptools pip debugpy ]))
      autoflake
      poetry
      python3Packages.ipython
      python3Packages.parso
      python3Packages.twine

      # Rust
      cargo
      perl
      rustc
  ];
}
