{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # discord
    # (discord.override {
    #  withVencord = true;
    # })
    # webcord-vencord
    vesktop # better discord client with vencord built-in
  ];
}
