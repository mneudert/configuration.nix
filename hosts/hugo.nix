{ config, pkgs, ... }:

let

    host = "hugo";
    secret_base = "/data/projects/secret/configuration.nix";

    secret = if builtins.pathExists "${secret_base}/hosts/${host}.nix"
             then "${secret_base}/hosts/${host}.nix"
             else {};

in {
  imports =
    [
      ./hugo/hardware-configuration.nix

      ./hugo/system-packages.nix

      ../system/default.nix
      ../users/mne.nix
      ../users/mne.nixpkgs.nix

      secret
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  services.sshd.enable = true;
  system.stateVersion = "18.09";
}
