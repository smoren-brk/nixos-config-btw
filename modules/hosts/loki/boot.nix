{
  flake.modules.nixos.host-loki =
    {
      pkgs,
      lib,
      theme,
      ...
    }:
    {
      boot = {
        loader = {
          limine = {
            enable = true;
            style = {
              wallpapers = [ ];
              backdrop = theme.raw.background;
              interface = {
                brandingColor = theme.raw.accent;
                helpColor = theme.raw.accent;
                helpColorBright = theme.raw.accent;
              };
              graphicalTerminal = {
                palette = lib.concatMapStringsSep ";" (lib.removePrefix "#") theme.ansi;
                brightPalette = lib.concatMapStringsSep ";" (lib.removePrefix "#") theme.ansiBright;
                background = theme.raw.background;
                foreground = theme.raw.foreground;
                brightBackground = theme.raw.background;
                brightForeground = theme.raw.fg0;
              };
            };
          };
          efi.canTouchEfiVariables = true;
        };
        kernelPackages = pkgs.linuxPackages_latest;
      };

    };
}
