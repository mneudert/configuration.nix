{ config, pkgs, ... }:

{
  imports =
    [
      ./legacy/hardware-configuration.nix
      ./legacy/system-packages.nix
      ./legacy/custom-packages.nix

      ../system/default.nix
    ];

  boot.loader.grub.enable  = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device  = "/dev/sdb";

  networking.hostName = "legacy";

  users.extraUsers.mne = {
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    uid = 1000;
  };

  system.stateVersion = "16.09";
}
