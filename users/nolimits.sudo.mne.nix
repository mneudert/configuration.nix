{ lib, ... }:

with lib;
{
  security.sudo.extraConfig =
    ''
      mne  ALL=(nolimits) NOPASSWD: ALL
      mne  ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/sysctl
    '';
}
