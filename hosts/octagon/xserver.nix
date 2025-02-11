{
  services.xserver = {
    enable = true;
    exportConfiguration = true;

    displayManager.gdm.enable = true;
    xkb.layout = "de";

    desktopManager = { gnome.enable = true; };
  };
}
