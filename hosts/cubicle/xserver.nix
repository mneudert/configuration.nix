{
  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    xserver = {
      enable = true;
      exportConfiguration = true;
      xkb.layout = "de";
    };
  };
}
