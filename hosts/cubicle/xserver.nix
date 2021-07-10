{
  services.xserver = {
    enable = true;
    exportConfiguration = true;

    layout = "de";

    displayManager.gdm.enable = true;

    desktopManager = { gnome3.enable = true; };
  };
}
