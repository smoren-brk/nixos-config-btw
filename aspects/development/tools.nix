{
  flake.modules.nixos.development-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      cargo
      devenv
      gcc
      pkgconf
      python3
    ];
  };
}
