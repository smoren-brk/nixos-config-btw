{
  flake.modules.homeManager.gtk = { pkgs, ... }: {
    gtk = {
      enable = true;
      colorScheme = "dark";

      theme = {
        name = "catppuccin-mocha-peach-standard";
        package = pkgs.catppuccin-gtk.override {
          variant = "mocha";
          accents = [ "peach" ];
        };
      };

      gtk4.extraConfig."gtk-theme-name" = "catppuccin-mocha-peach-standard";

      cursorTheme = {
        name = "catppuccin-mocha-peach-cursors";
        package = pkgs.catppuccin-cursors.mochaPeach;
        size = 24;
      };
    };

    home.pointerCursor = {
      enable = true;
      name = "catppuccin-mocha-peach-cursors";
      package = pkgs.catppuccin-cursors.mochaPeach;
      size = 24;

      gtk.enable = true;
      x11.enable = true;
    };
  };
}
