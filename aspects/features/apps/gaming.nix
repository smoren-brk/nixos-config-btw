{
  flake.modules.nixos.gaming = { pkgs, ... }: {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    environment.systemPackages = [
      pkgs.gamescope
    ];
  };
}
