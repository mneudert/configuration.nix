{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.phpstorm
    sublime4
    vscode
  ];
}
