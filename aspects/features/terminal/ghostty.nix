{
  flake.modules.nixos.ghostty = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.ghostty
    ];

    environment.variables = {
      TERM = "ghostty";
      TERMINAL = "ghostty";
    };
  };

  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      package = null;

      enableZshIntegration = true;
      systemd.enable = false;

      settings = {
        font-family = "Hasklug Nerd Font";
        theme = "Catppuccin Mocha";
        cursor-color = "#fab387";
        cursor-text = "#1e1e2e";
        selection-background = "#fab387";
        selection-foreground = "#1e1e2e";
        quit-after-last-window-closed = false;
        background-opacity = 0.7;
        window-padding-x = 20;
        window-padding-y = 20;
      };
    };
  };
}
