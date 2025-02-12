{ config, pkgs, ... }:

let

  host = "octagon";
  secret_base = "/data/projects/secret/configuration.nix";

  secret =
    if builtins.pathExists "${secret_base}/hosts/${host}.nix" then
      "${secret_base}/hosts/${host}.nix"
    else
      { };

in
{
  imports = [
    ./octagon/xserver.nix

    ./octagon/custom-packages.nix
    ./octagon/unfree-packages.nix
    ./octagon/system-packages.nix

    ../system/default.nix
    ../users/mne.nix
    ../users/mne.docker.nix
    ../users/mne.networkmanager.nix
    ../users/mne.nixpkgs.nix

    secret
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.etc.hosts.mode = "0644";

  networking.hostName = host;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w" ];

  programs.gnupg.agent.enable = true;

  system.stateVersion = "23.05";

  virtualisation.docker.enable = true;
  virtualisation.docker.extraOptions = "--config-file=${
    pkgs.writeText "daemon.json" (
      builtins.toJSON {
        data-root = "/data/docker";
        features = {
          buildkit = true;
        };
      }
    )
  }";
}
