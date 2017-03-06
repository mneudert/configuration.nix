{ config, pkgs, ... }:

{
  imports =
    [
      ./cubicle/hardware-configuration.nix
      ./cubicle/system-packages.nix
      ./cubicle/custom-packages.nix
      ./cubicle/xserver.nix

      ../system/default.nix
      ../users/mne.nix
    ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable      = true;

  hardware.bluetooth.enable = false;

  networking.hostName = "cubicle";

  system.stateVersion = "16.09";
}
