{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    atop
    file
    git
    gnupg
    ipmitool
    vim
    vimPlugins.vim-nix
    wget
    zsh
  ];
}
