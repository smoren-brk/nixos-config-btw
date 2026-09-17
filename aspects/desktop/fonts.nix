{
  flake.modules.nixos.fonts = { pkgs, ... }: {
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
  };
}
