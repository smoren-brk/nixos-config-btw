{ inputs, config, ... }:

{
  flake.nixosConfigurations.geist = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      inputs.home-manager.nixosModules.home-manager

      ({ pkgs, ... }: {
        boot = {
          loader = {
            limine.enable = true;
            efi.canTouchEfiVariables = true;
          };
          kernelPackages = pkgs.linuxPackages_latest;
        };

        networking.hostName = "geist";
        time.timeZone = "Europe/Belgrade";

        services = {
          xserver.xkb.layout = "us";
          getty.autologinUser = "jx";
        };

        system.stateVersion = "26.11";
      })
    ] ++ builtins.attrValues config.flake.modules.nixos;
  };
}
