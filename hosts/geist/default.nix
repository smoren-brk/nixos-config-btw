{ inputs, config, ... }:

{
  imports = [
    ./hardware.nix
    ./jx.nix
  ];

  flake.nixosConfigurations.geist = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      ({ pkgs, ... }: {
        boot = {
          loader = {
            limine = {
              enable = true;
              style = {
                wallpapers = [ ];
                backdrop = "1a1b26";
                interface = {
                  brandingColor = "7aa2f7";
                  helpColor = "7aa2f7";
                  helpColorBright = "7aa2f7";
                };
                graphicalTerminal = {
                  palette = "1a1b26;f7768e;9ece6a;e0af68;7aa2f7;bb9af7;73daca;c0caf5";
                  brightPalette = "414868;f7768e;9ece6a;e0af68;7aa2f7;bb9af7;73daca;c0caf5";
                  background = "1a1b26";
                  foreground = "c0caf5";
                  brightBackground = "414868";
                  brightForeground = "c0caf5";
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
