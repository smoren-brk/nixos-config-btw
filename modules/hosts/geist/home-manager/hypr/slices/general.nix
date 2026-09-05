{ lib, ... }:

{
  wayland.windowManager.hyprland.settings = {
    config = {
      input = {
        kb_layout = "us,rs";
        kb_variant = ",yz";
        kb_options = "caps:escape,grp:alt_shift_toggle";

        repeat_rate = 50;
        repeat_delay = 200;
        numlock_by_default = 1;

        accel_profile = "flat";
      };

      general = {
        gaps_out = 10;

        layout = "scrolling";
        border_size = 0;
      };

      misc = {
        swallow_regex = "^(Alacritty|kitty|footclient|foot|com.mitchellh.ghostty|org.gnome.Nautilus)$";
        enable_swallow = true;
      };
    };

    on = {
      _args = [
        "hyprland.start"
        (lib.generators.mkLuaInline ''
          function()
            hl.exec_cmd("qs")
          end
        '')
      ];
    };
  };
}
