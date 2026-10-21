{
  flake.modules.nixos.apps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      discord
      imv
      libreoffice
      transmission_4-gtk
      pcmanfm
      xplr
      yazi
      yt-dlp
    ];
  };
}
