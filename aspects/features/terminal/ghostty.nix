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
        background-opacity = 0.55;
        confirm-close-surface = false;
        custom-shader = "${./shaders/cursor-stars.glsl}";
        custom-shader-animation = "always";
        cursor-color = "#fab387";
        cursor-text = "#1e1e2e";
        font-family = "Hasklug Nerd Font";
        quit-after-last-window-closed = false;
        selection-background = "#fab387";
        selection-foreground = "#1e1e2e";
        theme = "Catppuccin Mocha";
        window-padding-x = 20;
        window-padding-y = 20;
      };
    };
  };
}
