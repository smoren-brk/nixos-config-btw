{
  flake.modules.homeManager.gtk = { pkgs, ... }: {
    gtk = {
      enable = true;
      colorScheme = "dark";

      theme = {
        name = "catppuccin-mocha-teal-standard";
        package = pkgs.catppuccin-gtk.override {
          variant = "mocha";
          accents = [ "teal" ];
        };
      };

      gtk4.extraConfig."gtk-theme-name" = "catppuccin-mocha-teal-standard";

      cursorTheme = {
        name = "catppuccin-mocha-teal-cursors";
        package = pkgs.catppuccin-cursors.mochaTeal;
        size = 24;
      };
    };

    home.pointerCursor = {
      enable = true;
      name = "catppuccin-mocha-teal-cursors";
      package = pkgs.catppuccin-cursors.mochaTeal;
      size = 24;

      gtk.enable = true;
      x11.enable = true;
    };
  };
}
