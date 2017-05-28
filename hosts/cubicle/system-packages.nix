# List packages installed in system profile.
#
# To search by name, run:
# $ nix-env -qaP | grep wget
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arduino
    bind
    chromium
    firefox
    git
    git-lfs
    gnupg
    imagemagick
    iw
    lshw
    openssl
    openvpn
    pciutils
    slack
    terminator
    travis
    unar
    vagrant
    vim
    wget
    wirelesstools
    zsh

    gitAndTools.diff-so-fancy
  ];
}
