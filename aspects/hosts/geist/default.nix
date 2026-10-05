{ inputs, config, ... }:

{
  flake.nixosConfigurations.geist = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.home-manager.nixosModules.home-manager

      ({ pkgs, ... }: {
        boot = {
          loader = {
            limine = {
              enable = true;
              style = {
                wallpapers = [ ];
                backdrop = "1e1e2e";
                interface = {
                  brandingColor = "a6e3a1";
                  helpColor = "a6e3a1";
                  helpColorBright = "a6e3a1";
                };
                graphicalTerminal = {
                  palette = "1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
                  brightPalette = "585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
                  background = "1e1e2e";
                  foreground = "cdd6f4";
                  brightBackground = "585b70";
                  brightForeground = "cdd6f4";
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
      })
    ]
    ++ builtins.attrValues config.flake.modules.nixos;
  };
}
