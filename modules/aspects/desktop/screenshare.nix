{
  flake.modules.nixos.screenshare = { pkgs, ... }: {
    programs.obs-studio.enable = true;
    services.pipewire.enable = true;

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
