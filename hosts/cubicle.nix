{ config, pkgs, ... }:

{
  imports =
    [
      ./cubicle/hardware-configuration.nix
      ./cubicle/xserver.nix

      ./cubicle/custom-packages.nix
      ./cubicle/unfree-packages.nix
      ./cubicle/system-packages.nix

      ../system/default.nix
      ../users/mne.nix
      ../users/mne.docker.nix
      ../users/mne.nixpkgs.nix
      ../users/mne.vboxusers.nix
    ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable      = true;

  hardware.bluetooth.enable = false;

  networking.hostName = "cubicle";

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "16.09";

  virtualisation.docker.enable          = true;
  virtualisation.virtualbox.host.enable = true;
}
