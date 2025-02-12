{ config, pkgs, ... }:

let

  host = "yunica";
  secret_base = "/data/projects/secret/configuration.nix";

  secret =
    if builtins.pathExists "${secret_base}/hosts/${host}.nix" then
      "${secret_base}/hosts/${host}.nix"
    else
      { };

in
{
  imports = [
    ./yunica/system-packages.nix

    ../system/default.nix
    ../users/mne.nix
    ../users/mne.nixpkgs.nix

    secret
  ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  boot.supportedFilesystems = [ "zfs" ];

  networking.hostName = host;
  networking.hostId = "f8f16df6";

  programs.gnupg.agent.enable = true;

  services.zfs.autoScrub.enable = true;
  services.zfs.autoScrub.interval = "weekly";

  system.stateVersion = "18.09";
}
