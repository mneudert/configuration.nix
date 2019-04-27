{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    atop
    file
    git
    gnupg
    vim
    vimPlugins.vim-nix
    wget
    zsh
  ];
}
