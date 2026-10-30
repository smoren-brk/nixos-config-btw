{
  flake.modules.nixos.apps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      imv
      transmission_4-gtk
      yazi
      yt-dlp
    ];
  };
}
