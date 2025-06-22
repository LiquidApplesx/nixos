{ config, pkgs, lib, ... }:

let
  polkitAgent = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
in
{
  # 1) Enable the system-wide polkit daemon
  security.polkit.enable = true;

  # 2) Make sure both engine and GNOME‐style agent are installed
  environment.systemPackages = with pkgs; [
    polkit
    polkit_gnome
  ];

  # 3) Auto-start the GNOME agent in any graphical session
  systemd.user.services.polkit-gnome-authentication-agent = {
    description = "PolicyKit Authentication Agent";
    wantedBy    = [ "graphical-session.target" ];
    serviceConfig = {
      Type      = "simple";
      ExecStart = polkitAgent;
    };
  };
}

