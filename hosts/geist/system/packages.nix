{
  pkgs,
  raito,
  torlink,
  ...
}:

let
  vendoredPackages = [
    raito.packages.${pkgs.stdenv.hostPlatform.system}.default
    torlink.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  devTools = with pkgs; [
    cargo
    codex
    gcc
    odin
    python3
  ];

  waylandUtils = with pkgs; [
    awww
    grim
    slurp
    swappy
    wl-clipboard-rs
    xwayland-satellite
  ];
in
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = vendoredPackages ++ devTools ++ waylandUtils;
}
