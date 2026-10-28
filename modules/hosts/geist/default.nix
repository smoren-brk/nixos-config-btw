{ inputs, config, ... }:

{
  imports = [
    ./hardware.nix
    ./jx.nix
  ];

  flake.nixosConfigurations.geist = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      (
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

          networking.hostName = "geist";
          time.timeZone = "Europe/Belgrade";

          services = {
            xserver.xkb.layout = "us";
          };

          system.stateVersion = "26.11";
        }
      )
    ]
    ++ builtins.attrValues config.flake.modules.nixos;
  };
}
