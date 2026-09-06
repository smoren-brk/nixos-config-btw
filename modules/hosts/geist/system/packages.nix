{ pkgs, raito, ... }:

let
  vendoredPackages = [
    raito.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  systemUtils = [
    pkgs.bat
    pkgs.btop
    pkgs.btrfs-progs
    pkgs.eza
    pkgs.fastfetch
    pkgs.fzf
    pkgs.killall
    pkgs.ripgrep
    pkgs.tealdeer
    pkgs.tree
    pkgs.zoxide
  ];

  devTools = [
    pkgs.cargo
    pkgs.gcc
    pkgs.git
    pkgs.nixfmt
    pkgs.prettier
    pkgs.python3
    pkgs.tree-sitter
    pkgs.odin
    pkgs.ols # Odin language server
    pkgs.nix-search-tv # Search Nix packages from the terminal
  ];

  waylandUtils = [
    pkgs.gamescope
    pkgs.grim
    pkgs.slurp
    pkgs.swappy
    pkgs.wl-clipboard-rs
    pkgs.xdg-desktop-portal-hyprland
    pkgs.rofi # App launcher
    pkgs.quickshell # Launcher/shell (duplicate removed)
    pkgs.waybar # Status bar
    pkgs.hyprpaper # Wallpaper setter
  ];

  guiApps = [
    pkgs.qutebrowser
    pkgs.vesktop # Discord client
    pkgs.transmission_4-gtk
    pkgs.mpv
    pkgs.imv # Image viewer
    pkgs.pavucontrol # Audio volume control
    pkgs.zathura # Document viewer
    pkgs.zathuraPkgs.zathura_cb
    pkgs.zathuraPkgs.zathura_djvu
    pkgs.zathuraPkgs.zathura_pdf_mupdf
    pkgs.zathuraPkgs.zathura_pdf_poppler
    pkgs.zathuraPkgs.zathura_ps
    pkgs.yazi # Terminal file manager (TUI)
  ];

  shellStuff = [
    pkgs.ghostty # Terminal emulator
    pkgs.zsh-powerlevel10k # Zsh prompt theme
  ];


  misc = [
    pkgs.home-manager
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
