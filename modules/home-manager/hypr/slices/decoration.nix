{ lib, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      curve = {
        _args = [
          "overshoot"
          {
            type = "bezier";
            points = [
              (lib.generators.mkLuaInline "{ 0.1, 0.9 }")
              (lib.generators.mkLuaInline "{ 0.15, 1.05 }")
            ];
          }
        ];
      };

      config = {
        decoration = {
          blur = {
            passes = 2;
            special = true;
          };

          rounding = 8;
        };
      };

      animation = [
        {
          leaf = "windows";
          enabled = true;
          speed = 3;
          bezier = "overshoot";
          style = "slide";
        }

        {
          leaf = "workspaces";
          enabled = true;
          speed = 3;
          bezier = "default";
          style = "slidevert";
        }

        {
          leaf = "workspacesIn";
          enabled = true;
          speed = 3;
          bezier = "default";
          style = "slidevert";
        }

        {
          leaf = "workspacesOut";
          enabled = true;
          speed = 3;
          bezier = "default";
          style = "slidevert";
        }
      ];
    };
  };
}
