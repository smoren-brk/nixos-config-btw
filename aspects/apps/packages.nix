# { inputs, ... }:

{
  # flake-file.inputs.torlink = {
  #   url = "github:baairon/torlink";
  #   inputs.nixpkgs.follows = "nixpkgs";
  # };

  flake.modules.nixos.apps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # inputs.torlink.packages.${pkgs.stdenv.hostPlatform.system}.default

      discord
      imv
      transmission_4-gtk
      libreoffice
      yazi
      yt-dlp
      xplr
    ];
  };
}
