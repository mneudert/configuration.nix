{
  services.xserver = {
    enable              = true;
    exportConfiguration = true;

    layout = "de";

    displayManager.gdm.enable = true;

    desktopManager = {
      default       = "gnome3";
      gnome3.enable = true;
    };
  };
}
