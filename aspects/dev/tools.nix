{
  flake.modules.nixos.development-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      cargo
      gcc
      odin
      pkgconf
      python3
    ];
  };
}
