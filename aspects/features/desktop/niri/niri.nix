{ inputs, ... }:

{
  flake.modules.nixos.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
      package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (_: {
        doCheck = false;
      });
    };

    environment = {
      systemPackages = with pkgs; [
        inputs.oniri.packages.${pkgs.stdenv.hostPlatform.system}.default
        awww
        grim
        slurp
        swappy
        wl-clipboard-rs
        xwayland-satellite
      ];

      variables = {
        NIXOS_OZONE_WL = "1";
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
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/aspects/features/desktop/niri/_config";

  };
}
