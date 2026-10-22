{
  flake.modules.nixos.development-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      cargo
      gcc
      pkgconf
      python3
    ];
  };
}
