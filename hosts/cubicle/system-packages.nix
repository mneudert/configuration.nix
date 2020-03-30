{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arduino
    atop
    bind
    chromium
    dbeaver
    file
    firefox
    gimp
    git
    git-lfs
    gitAndTools.diff-so-fancy
    gnome3.evolution
    gnome3.gnome-tweak-tool
    gnupg
    imagemagick
    iw
    lshw
    nssTools
    openssl
    openvpn
    pciutils
    slack
    subversion
    terminator
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
