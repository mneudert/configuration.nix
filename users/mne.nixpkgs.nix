{ lib, ... }:

with lib;
{
  system.activationScripts = {
    dotfiles_mne_nixpkgs = stringAfter [ "users" ]
    ''
      cd /home/mne

      rm -f .nixpkgs
      ln -fs ${../dotfiles/nixpkgs} .nixpkgs

      chown -h mne:users .nixpkgs
    '';
  };

}
