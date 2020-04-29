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
  hardware.cpu.intel.updateMicrocode = true;

  networking.hostName = host;

  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent.enable = true;

  system.stateVersion = "20.03";

  virtualisation.docker.enable = true;
  virtualisation.docker.extraOptions = "--config-file=${pkgs.writeText "daemon.json" (builtins.toJSON { features = { buildkit = true; }; })}";
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
}
