{ inputs, ... }:

{
  flake.modules.nixos.apps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      inputs.torlink.packages.${pkgs.stdenv.hostPlatform.system}.default

      discord
      imv
      superfile
      transmission_4-gtk
      libreoffice
      yazi
      youtube-tui
      yt-dlp
    ];
  };
}
