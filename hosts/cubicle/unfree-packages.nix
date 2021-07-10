{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ idea.phpstorm sublime3 vscode ];
}
