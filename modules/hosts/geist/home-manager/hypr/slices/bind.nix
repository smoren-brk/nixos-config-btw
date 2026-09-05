{ lib, ... }:

{
  wayland.windowManager.hyprland.settings = {
    bind = [
      {
        _args = [
          "SUPER + RETURN"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("ghostty")'')
        ];
      }

      {
        _args = [
          "SUPER + R"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("ghostty -e yazi")'')
        ];
      }

      {
        _args = [
          "SUPER + D"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("rofi -show run")'')
        ];
      }

      {
        _args = [
          "SUPER + W"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("firefox")'')
        ];
      }

      {
        _args = [
          "SUPER + M"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pavucontrol")'')
        ];
      }

      {
        _args = [
          "SUPER + P"
          (lib.generators.mkLuaInline "hl.dsp.workspace.toggle_special()")
        ];
      }

      {
        _args = [
          "SUPER + SHIFT + P"
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "special" })'')
        ];
      }

      {
        _args = [
          "SUPER + Tab"
          (lib.generators.mkLuaInline "hl.dsp.window.cycle_next()")
        ];
      }

      # ─────────────────────────────────────────────────────────────
      # Focus / window management
      # ─────────────────────────────────────────────────────────────

      {
        _args = [
          "SUPER + H"
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "left" })'')
        ];
      }

      {
        _args = [
          "SUPER + L"
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "right" })'')
        ];
      }

      {
        _args = [
          "SUPER + Q"
          (lib.generators.mkLuaInline "hl.dsp.window.close()")
        ];
      }

      {
        _args = [
          "SUPER + SHIFT + F"
          (lib.generators.mkLuaInline ''hl.dsp.window.float({ action = "toggle" })'')
        ];
      }

      # ─────────────────────────────────────────────────────────────
      # Fullscreen
      # ─────────────────────────────────────────────────────────────

      {
        _args = [
          "SUPER + SPACE"
          (lib.generators.mkLuaInline ''
            hl.dsp.window.fullscreen({
              mode = "maximized",
              action = "toggle",
            })
          '')
        ];
      }

      {
        _args = [
          "SUPER + SHIFT + SPACE"
          (lib.generators.mkLuaInline ''
            hl.dsp.window.fullscreen({
              mode = "fullscreen",
              action = "toggle",
            })
          '')
        ];
      }

      {
        _args = [
          "SUPER + CONTROL + SPACE"
          (lib.generators.mkLuaInline ''
            hl.dsp.window.fullscreen({
              mode = "maximized",
              action = "toggle",
            })
          '')
        ];
      }

      # Compositor
      {
        _args = [
          "SUPER + SHIFT + Q"
          (lib.generators.mkLuaInline "hl.dsp.exit()")
        ];
      }

      # ─────────────────────────────────────────────────────────────
      # Hardware
      # ─────────────────────────────────────────────────────────────

      {
        _args = [
          "XF86AudioMute"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle")'')
          {
            locked = true;
          }
        ];
      }

      {
        _args = [
          "XF86AudioLowerVolume"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%")'')
          {
            locked = true;
            repeating = true;
          }
        ];
      }

      {
        _args = [
          "XF86AudioRaiseVolume"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%")'')
          {
            locked = true;
            repeating = true;
          }
        ];
      }

      {
        _args = [
          "SUPER + O"
          (lib.generators.mkLuaInline ''
            hl.dsp.exec_cmd("pactl set-default-sink alsa_output.usb-Corsair_Corsair_HS65_SURROUND-00.analog-stereo")
          '')
          {
            locked = true;
            repeating = true;
          }
        ];
      }

      {
        _args = [
          "SUPER + SHIFT + O"
          (lib.generators.mkLuaInline ''
            hl.dsp.exec_cmd("pactl set-default-sink alsa_output.pci-0000_15_00.6.analog-stereo")
          '')
          {
            locked = true;
            repeating = true;
          }
        ];
      }

      {
        _args = [
          "XF86AudioPlay"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("playerctl play-pause")'')
          {
            locked = true;
          }
        ];
      }

      # Brightness
      {
        _args = [
          "XF86MonBrightnessDown"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("raito --all set -20")'')
          {
            locked = true;
            repeating = true;
          }
        ];
      }

      {
        _args = [
          "XF86MonBrightnessUp"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("raito --all set +20")'')
          {
            locked = true;
            repeating = true;
          }
        ];
      }

      # ─────────────────────────────────────────────────────────────
      # Mouse
      # ─────────────────────────────────────────────────────────────

      {
        _args = [
          "SUPER + mouse:272"
          (lib.generators.mkLuaInline "hl.dsp.window.drag()")
          {
            mouse = true;
          }
        ];
      }

      {
        _args = [
          "SUPER + mouse:273"
          (lib.generators.mkLuaInline "hl.dsp.window.resize()")
          {
            mouse = true;
          }
        ];
      }
    ];
  };
}
