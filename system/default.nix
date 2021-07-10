{
  boot.tmpOnTmpfs = true;

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  i18n = { defaultLocale = "en_US.UTF-8"; };

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;

  time.timeZone = "Europe/Berlin";

  security.sudo.enable = true;

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
}
