{ config, pkgs, ... }:

{
  imports =
    [
      ./legacy/hardware-configuration.nix
      ./legacy/system-packages.nix
      ./legacy/custom-packages.nix

      ../system/default.nix
      ../users/mne.nix
    ];

  boot.loader.grub.enable  = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device  = "/dev/sdb";

  networking.hostName = "legacy";

  system.stateVersion = "16.09";
}
