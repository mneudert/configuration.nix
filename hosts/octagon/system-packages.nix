{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    atop
    bind
    chromium
    diff-so-fancy
    evolution
    file
    firefox
    gimp
    git
    git-lfs
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
