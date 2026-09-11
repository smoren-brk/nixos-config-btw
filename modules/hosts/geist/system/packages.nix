{ pkgs, qml-niri, raito, ... }:

let
  vendoredPackages = [
    qml-niri.packages.${pkgs.stdenv.hostPlatform.system}.quickshell
    raito.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  systemUtils = with pkgs; [
    bat
    btop
    btrfs-progs
    eza
    fastfetch
    fzf
    killall
    microfetch
    ripgrep
    tealdeer
    tree
    zoxide
  ];

  devTools = with pkgs; [
    cargo
    codex
    gcc
    git
    nix-search-tv
    nixfmt
    odin
    ols
    prettier
    python3
    tree-sitter
  ];

  waylandUtils = with pkgs; [
    gamescope
    grim
    hyprpaper
    slurp
    swappy
    wl-clipboard-rs
    xdg-desktop-portal-hyprland
    xwayland-satellite
  ];

  guiApps = with pkgs; [
    discord
    imv
    mpv
    pavucontrol
    qutebrowser
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
    ghostty
    gnutar
    unzip
    zsh-powerlevel10k
  ];


  misc = with pkgs; [
    home-manager
  ];

in
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = vendoredPackages ++ systemUtils ++ devTools ++ waylandUtils ++ guiApps ++ shellStuff ++ misc;

  fonts.packages = with pkgs; [
    fira-code-symbols
    liberation_ttf
    nerd-fonts._0xproto
    nerd-fonts.fira-code
    nerd-fonts.hasklug
    nerd-fonts.iosevka
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

}
