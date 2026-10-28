{
  flake.modules.nixos.eumlation = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      azahar
      melonds
    ];
  };
}
