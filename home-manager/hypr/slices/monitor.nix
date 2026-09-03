{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        output = "DP-2";
        mode = "1920x1080@165";
        position = "auto-right";
        scale = 1;
        bitdepth = 10;
        supports_hdr = 1;
        supports_wide_color = 0;
      }

      {
        output = "DP-1";
        mode = "3440x1440@180";
        position = "auto-left";
        scale = 1;
        bitdepth = 10;
        supports_hdr = 1;
        supports_wide_color = 0;
      }
    ];

  };
}
