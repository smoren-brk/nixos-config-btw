{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Torrent Options
      {
        name = "Torrent Options float center size";
        match = {
          title = "^(Torrent Options)$";
        };
        float = true;
        center = true;
        size = [ "45%" "60%" ];
      }

      # Picture-in-Picture
      {
        name = "Picture-in-Picture float center size";
        match = {
          title = "^(Picture-in-Picture)$";
        };
        float = true;
        center = true;
        size = [ "60%" "60%" ];
      }

      # btoppy
      {
        name = "btoppy float center size";
        match = {
          title = "^(btoppy)$";
        };
        float = true;
        center = true;
        size = [
          "(monitor_w*0.5)"
          "(monitor_h*0.5)"
        ];
      }

      # Scratchpad
      {
        name = "Scratchpad silent workspace";
        match = {
          title = "^(scratchpad)$";
        };
        workspace = "special silent";
      }

      # Common dialogs/popups
      {
        name = "file_progress float";
        match = {
          title = "^(file_progress)$";
        };
        float = true;
      }

      {
        name = "confirm float";
        match = {
          title = "^(confirm)$";
        };
        float = true;
      }

      {
        name = "dialog float";
        match = {
          title = "^(dialog)$";
        };
        float = true;
      }

      {
        name = "download float";
        match = {
          title = "^(download)$";
        };
        float = true;
      }

      {
        name = "notification float";
        match = {
          title = "^(notification)$";
        };
        float = true;
      }

      {
        name = "error float";
        match = {
          title = "^(error)$";
        };
        float = true;
      }

      {
        name = "splash float";
        match = {
          title = "^(splash)$";
        };
        float = true;
      }

      {
        name = "confirmreset float";
        match = {
          title = "^(confirmreset)$";
        };
        float = true;
      }

      {
        name = "Open File float";
        match = {
          title = "^(Open File)$";
        };
        float = true;
      }

      {
        name = "branchdialog float";
        match = {
          title = "^(branchdialog)$";
        };
        float = true;
      }
    ];
  };
}

