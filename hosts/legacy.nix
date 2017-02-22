{ config, pkgs, ... }:

{
  imports =
    [
      ./legacy/hardware-configuration.nix
      ./legacy/system-packages.nix
      ./legacy/custom-packages.nix
    ];

  boot.loader.grub.enable  = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device  = "/dev/sdb";

  networking.hostName = "legacy";

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "de";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Berlin";

  services.openssh.enable = true;

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
  users.extraUsers.mne   = {
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    uid = 1000;
  };

  system.stateVersion = "16.09";

  security.sudo.enable = true;
}
