{ lib, ... }:

with lib;
{
  users.extraUsers.mne = {
    description = "Marc Neudert";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    uid = 1000;
  };

  system.activationScripts = {
    dotfiles_mne = stringAfter [ "users" ]
    ''
      cd /home/mne

      # symlink directories
      rm -f .nix-shells
      ln -fs ${../shells} .nix-shells

      chown -h mne:users .nix-shells

      # symlink files
      ln -fs ${../dotfiles/profile} .profile
      ln -fs ${../dotfiles/zshrc} .zshrc

      chown -h mne:users .profile
      chown -h mne:users .zshrc
    '';
  };
}
