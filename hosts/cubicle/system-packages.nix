{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arduino
    atop
    bind
    chromium
    file
    firefox
    gimp
    git
    git-lfs
    gnupg
    imagemagick
    iw
    lshw
    nssTools
    openssl
    openvpn
    pciutils
    qgis
    slack
    subversion
    terminator
    travis
    unar
    unzip
    vagrant
    vim
    vimPlugins.vim-nix
    wget
    wirelesstools
    wireshark
    zsh
  ];
}
