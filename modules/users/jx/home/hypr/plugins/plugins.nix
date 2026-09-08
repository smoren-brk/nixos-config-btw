{ ... }:

{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      local smw = require("plugins.split-monitor-workspaces")

      smw.setup({
          workspace_count = 5,
          monitor_priority = { "DP-1", "DP-2" },
          keep_focused = false,
          enable_persistent_workspaces = true,
      })

      for i = 1, 5 do
        local n = tostring(i)
        hl.bind("SUPER +" .. n, smw.workspace(n))
        hl.bind("SUPER + SHIFT +" .. n, smw.move_to_workspace_silent(n))
      end
    '';
  };
}
