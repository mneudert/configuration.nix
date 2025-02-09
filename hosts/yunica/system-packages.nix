{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    atop
    file
    git
    gnupg
    ipmitool
    nixfmt-rfc-style
    openssl
    pinentry
    vim
    vimPlugins.vim-nix
    wget
    zsh
  ];
}
