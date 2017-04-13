{ lib, ... }:

with lib;
{
  security.sudo.extraConfig =
    ''
      mne  ALL=(nolimits) NOPASSWD: ALL
    '';
}
