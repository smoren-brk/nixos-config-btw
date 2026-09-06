{ pkgs
, ...
}:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    bat
    btop
    btrfs-progs
    cargo
    eza
    fastfetch
    fzf
    gamescope
    gcc
    ghostty
    git
    grim
    home-manager
    hyprpaper
    imv
    killall
    mpv
    nix-search-tv
    nixfmt
    odin
    ols
    pavucontrol
    prettier
    python3
    quickshell
    quickshell
    qutebrowser
    ripgrep
    rofi
    slurp
    swappy
    tealdeer
    transmission_4-gtk
    tree
    tree-sitter
    vesktop
    waybar
    wl-clipboard-rs
    xdg-desktop-portal-hyprland
    yazi
    zathura
    zathuraPkgs.zathura_cb
    zathuraPkgs.zathura_djvu
    zathuraPkgs.zathura_pdf_mupdf
    zathuraPkgs.zathura_pdf_poppler
    zathuraPkgs.zathura_ps
    zoxide
    zsh-powerlevel10k
  ];

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
