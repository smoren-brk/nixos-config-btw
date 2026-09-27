{
  flake.modules.nixos.anki = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      anki
    ];
  };

  flake.modules.homeManager.anki = {

  };
}
