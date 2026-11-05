{
  flake.modules.nixos.development-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      devenv
      pkgconf
      python3
    ];
  };
}
