{ lib, ... }:

with lib;
{
  users.extraUsers.mne = {
    extraGroups  = [ "wheel" ];
    isNormalUser = true;
    uid          = 1000;
  };

  system.activationScripts = {
    dotfiles_mne = stringAfter [ "users" ]
    ''
      cd /home/mne

      ln -fs ${../dotfiles/profile} .profile

      chown -h mne:users .profile
    '';
  };
}
