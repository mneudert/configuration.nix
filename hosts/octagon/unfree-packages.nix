{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ sublime4 vscode ];
}
