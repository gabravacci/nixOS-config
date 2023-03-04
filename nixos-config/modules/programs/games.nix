#
# games and stuff
#

{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [
    # pkgs.lutris
    pkgs.retroarchFull
  ];
}
