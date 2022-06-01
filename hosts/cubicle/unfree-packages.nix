{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ jetbrains.phpstorm sublime3 vscode ];
}
