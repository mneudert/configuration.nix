{
  boot.tmpOnTmpfs = true;

  i18n = {
    consoleFont   = "Lat2-Terminus16";
    consoleKeyMap = "de";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Berlin";

  security.sudo.enable = true;

  services.openssh.enable = true;

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
}
