{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    decoration = {
      blur = {
        passes = 2;
        special = true;
      };

      rounding = 8;
    };

    bezier = [
      {
        name = "overshoot";
        type = "bezier";
        points = [
          [ 0.1 0.9 ]
          [ 0.15 1.05 ]
        ];
      }
    ];

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
}
