{ pkgs, ... }:
let
  splashtop-business = pkgs.callPackage ../../pkgs/2048/splashtop-business.nix { };
in
{
  home.packages = with pkgs; [
    microsoft-edge
    teams-for-linux
    splashtop-business
    evolution
    evolution-ews
  ];
}
