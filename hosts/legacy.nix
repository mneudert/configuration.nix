{ config, pkgs, ... }:

let

    host        = "legacy";
    secret_base = "/data/projects/secret/configuration.nix";
    secret      = if builtins.pathExists "${secret_base}/hosts/${host}.nix"
                  then "${secret_base}/hosts/${host}.nix"
                  else {};

in {
  imports =
    [
      ./legacy/hardware-configuration.nix
      ./legacy/system-packages.nix
      ./legacy/custom-packages.nix

      ../system/default.nix
      ../users/mne.nix

      secret
    ];

  boot.loader.grub.enable  = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device  = "/dev/sdb";

  networking.hostName = host;

  system.stateVersion = "17.03";
}
