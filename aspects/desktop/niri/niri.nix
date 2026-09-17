{
  flake.modules.nixos.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = [
          "gnome"
          "gtk"
        ];
        niri.default = [
          "gnome"
          "gtk"
        ];
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };

    environment = {
      variables = {
        XDG_CURRENT_DESKTOP = "niri";
      };
    };

  };

  flake.modules.homeManager.niri = { config, ... }: {
    wayland.windowManager.niri = {
      enable = true;
      package = null;
      portalPackage = null;
      xwaylandSatellitePackage = null;
      systemd.enable = false;
    };

    xdg.configFile."niri".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/aspects/desktop/niri/_config";

  };
}
