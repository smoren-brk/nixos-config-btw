{ inputs, ... }:

{
  flake.modules.nixos.gaming = { pkgs, ... }: {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [
      gamescope
      inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
