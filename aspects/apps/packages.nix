{
  flake.modules.nixos.apps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      discord
      imv
      libreoffice
      transmission_4-gtk
      xplr
      yazi
      yt-dlp
    ];
  };
}
