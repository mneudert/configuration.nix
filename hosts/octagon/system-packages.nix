{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    atop
    bind
    chromium
    evolution
    file
    firefox
    gimp
    git
    git-lfs
    gitAndTools.diff-so-fancy
    gnome-tweaks
    gnupg
    imagemagick
    jq
    lshw
    nixfmt-rfc-style
    nssTools
    openssl
    pciutils
    terminator
    unzip
    vim
    vimPlugins.vim-nix
    wget
    zsh
  ];
}
