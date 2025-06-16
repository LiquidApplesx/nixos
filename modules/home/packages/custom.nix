{ pkgs, ... }:
let
  _2048 = pkgs.callPackage ../../../pkgs/2048/default.nix { };
  _2049 = pkgs.callPackage ../../../pkgs/2048/splashtop-business.nix { };
in
{
  home.packages = [
    _2048
    _2049
  ];
}
