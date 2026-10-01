{
  flake.modules.nixos.development-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      cargo
      codex
      gcc
      odin
      go
      pkgconf
      python3
    ];
  };
}
