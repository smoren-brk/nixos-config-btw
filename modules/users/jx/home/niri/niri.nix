{ ... }:

{
  wayland.windowManager.niri = {
    enable = true;
    package = null;
    portalPackage = null;
    xwaylandSatellitePackage = null;
    systemd.enable = false;
  };

  services.hyprpaper = {
    enable = true;
    package = null;
    settings = {
      wallpaper = [
        {
          monitor = "";
          path = "/home/jx/user/dl/nix-wave.png";
        }
      ];
    };
  };

  xdg.configFile."niri".source = ./config;
}
