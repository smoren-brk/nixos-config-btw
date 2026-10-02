{
  flake.modules.nixos.development-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      cargo
      codex
      gcc
      odin
      pkgconf
      python3
    ];
  };
}
