{ inputs, ... }:

{
  flake.modules.nixos.apps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      inputs.torlink.packages.${pkgs.stdenv.hostPlatform.system}.default

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
