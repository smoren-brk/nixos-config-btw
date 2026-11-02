{
  flake.modules.nixos.emulation = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      azahar
      melonds
    ];
  };
}
