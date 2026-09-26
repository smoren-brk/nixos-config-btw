{
  flake.modules.nixos.fonts = { pkgs, ... }: {
    gtk = {
      enable = true;

      theme = {
        name = "catppuccin-mocha-muave-standard";
        package = pkgs.catppuccin-gtk.override {
          variant = "mocha";
        };
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      colorScheme = "dark";
    };
  };
}
