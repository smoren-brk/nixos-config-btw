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
    gamescope
    grim
    slurp
    swappy
    wl-clipboard-rs
    xwayland-satellite
  ];

  guiApps = with pkgs; [
    discord
    imv
    mpv
    qutebrowser
    spotify
    transmission_4-gtk
    yazi
    yt-dlp
    zathura
    zathuraPkgs.zathura_cb
    zathuraPkgs.zathura_djvu
    zathuraPkgs.zathura_pdf_mupdf
    zathuraPkgs.zathura_pdf_poppler
    zathuraPkgs.zathura_ps
  ];

  shellStuff = with pkgs; [
    bitwarden-cli
    ghostty
    gnutar
    unzip
  ];

  misc = with pkgs; [
    home-manager
    youtube-tui
  ];

in
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    vendoredPackages ++ systemUtils ++ devTools ++ waylandUtils ++ guiApps ++ shellStuff ++ misc;
}
