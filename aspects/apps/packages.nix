{
  flake.modules.nixos.apps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      discord
      imv
      spotify
      transmission_4-gtk
      yazi
      youtube-tui
      yt-dlp
    ];
  };
}
