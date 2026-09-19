{
  flake.modules.nixos.audio = { pkgs, ... }: {
    programs.obs-studio.enable = true;

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

  };
}
