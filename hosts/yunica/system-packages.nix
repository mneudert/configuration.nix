{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    atop
    file
    git
    gnupg
    ipmitool
    nixfmt
    openssl
    pinentry
    vim
    vimPlugins.vim-nix
    wget
    zsh
  ];
}
