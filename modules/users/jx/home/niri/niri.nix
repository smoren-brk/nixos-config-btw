{ ... }:

{
  wayland.windowManager.niri = {
    enable = true;
    package = null;
    portalPackage = null;
    xwaylandSatellitePackage = null;
    systemd.enable = false;
  };

  xdg.configFile."niri".source = ./config;
}
