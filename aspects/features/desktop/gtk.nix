{
  flake.modules.homeManager.gtk = { pkgs, ... }: {
    gtk = {
      enable = true;
      colorScheme = "dark";

      theme = {
        name = "catppuccin-mocha-green-standard";
        package = pkgs.catppuccin-gtk.override {
          variant = "mocha";
          accents = [ "green" ];
        };
      };

      gtk4.extraConfig."gtk-theme-name" = "catppuccin-mocha-green-standard";

      cursorTheme = {
        name = "catppuccin-mocha-green-cursors";
        package = pkgs.catppuccin-cursors.mochaGreen;
        size = 24;
      };
    };

    home.pointerCursor = {
      enable = true;
      name = "catppuccin-mocha-green-cursors";
      package = pkgs.catppuccin-cursors.mochaGreen;
      size = 24;

      gtk.enable = true;
      x11.enable = true;
    };
  };
}
