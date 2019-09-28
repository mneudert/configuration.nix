{ config, pkgs, ... }:

let

    host = "cubicle";
    secret_base = "/data/projects/secret/configuration.nix";

    secret = if builtins.pathExists "${secret_base}/hosts/${host}.nix"
             then "${secret_base}/hosts/${host}.nix"
             else {};

in {
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
      ../users/mne.networkmanager.nix
      ../users/mne.nixpkgs.nix
      ../users/mne.vboxusers.nix

      secret
    ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  hardware.bluetooth.enable = false;

  networking.hostName = host;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "18.09";

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
