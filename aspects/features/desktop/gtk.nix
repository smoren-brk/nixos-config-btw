{
  flake.modules.homeManager.gtk = { pkgs, ... }: {
    gtk = {
      enable = true;
      colorScheme = "dark";

      theme = {
        name = "catppuccin-mocha-mauve-standard";
        package = pkgs.catppuccin-gtk.override {
          variant = "mocha";
          accents = [ "mauve" ];
        };
      };

      gtk4.extraConfig."gtk-theme-name" = "catppuccin-mocha-mauve-standard";

      cursorTheme = {
        name = "catppuccin-mocha-mauve-cursors";
        package = pkgs.catppuccin-cursors.mochaMauve;
        size = 24;
      };
    };

    home.pointerCursor = {
      enable = true;
      name = "catppuccin-mocha-mauve-cursors";
      package = pkgs.catppuccin-cursors.mochaMauve;
      size = 24;

      gtk.enable = true;
      x11.enable = true;
    };
  };
}
