# List packages installed in system profile.
#
# To search by name, run:
# $ nix-env -qaP | grep wget
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arduino
    atop
    bind
    chromium
    firefox
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
    terminator
    travis
    unar
    vagrant
    vim
    wget
    wirelesstools
    wireshark
    zsh
  ];
}
