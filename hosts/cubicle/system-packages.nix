# List packages installed in system profile.
#
# To search by name, run:
# $ nix-env -qaP | grep wget
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    firefox
    git
    git-lfs
    gnupg
    iw
    lshw
    openvpn
    pciutils
    slack
    terminator
    vagrant
    vim
    wget
    wirelesstools
    zsh

    gitAndTools.diff-so-fancy
  ];
}
