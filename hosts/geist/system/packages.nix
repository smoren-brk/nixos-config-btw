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

  systemUtils = with pkgs; [
    bat
    btop
    btrfs-progs
    eza
    fastfetch
    fzf
    killall
    tealdeer
    tree
    zoxide
    xdg-user-dirs
  ];

  devTools = with pkgs; [
    cargo
    codex
    gcc
    nix-search-tv
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

  shellStuff = with pkgs; [
    bitwarden-cli
    ghostty
    gnutar
    unzip
  ];

  misc = with pkgs; [
    home-manager
  ];

in
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    vendoredPackages ++ systemUtils ++ devTools ++ waylandUtils ++ shellStuff ++ misc;
}
