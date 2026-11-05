{ inputs, config, ... }:
{
  flake.nixosConfigurations.loki = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ config.flake.modules.nixos.host-loki ];
  };

  flake.modules.nixos.host-loki = {
    imports = with config.flake.modules.nixos; [
      ./_hardware.nix
      profile-base
      profile-workstation
      profile-development
      profile-gaming
      user-jx
      jellyfin
    ];

    networking.hostName = "loki";
    time.timeZone = "Europe/Belgrade";
    services.xserver.xkb.layout = "us";
    system.stateVersion = "26.11";

    services.speechd.enable = false;
  };
}
