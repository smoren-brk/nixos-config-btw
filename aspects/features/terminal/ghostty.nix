{
  flake.modules.nixos.ghostty = { pkgs, ... }: {
    fonts.packages = [ pkgs.nerd-fonts.hasklug ];

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
        cursor-color = "#a6e3a1";
        cursor-text = "#1e1e2e";
        font-family = "Hasklug Nerd Font";
        quit-after-last-window-closed = false;
        selection-background = "#a6e3a1";
        selection-foreground = "#1e1e2e";
        theme = "Catppuccin Mocha";
        window-padding-x = 20;
        window-padding-y = 20;
      };
    };
  };
}
