# List packages installed in system profile.
#
# To search by name, run:
# $ nix-env -qaP | grep wget
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    docker
    firefox
    git
    git-lfs
    gnupg
    openvpn
    terminator
    vagrant
    vim
    virtualbox
    wget
    zsh
  ];
}
