{ ... }:

{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      local smw = require("plugins.split-monitor-workspaces")

      smw.setup({
          workspace_count = 5,
          monitor_priority = { "DP-1", "DP-2" },
          keep_focused = false,
          enable_persistent_workspaces = false,
      })

      for i = 1, 20 do
        local n = ""

        if i < 11 then
            n = tostring(i)
        else
            n = tostring(i - 10)
        end

        if n == "10" or n == "20" then n = "0" end
        hl.bind("SUPER +" .. n, smw.workspace(n))
        hl.bind("SUPER + SHIFT +" .. n, smw.move_to_workspace_silent(n))
      end
    '';
  };
}
