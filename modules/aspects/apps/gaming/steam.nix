{
  flake.modules.nixos.steam = { pkgs, ... }: {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = false;
    };

    environment.systemPackages = with pkgs; [
      gamescope
    ];
  };
}
