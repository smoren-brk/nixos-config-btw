{ inputs, ... }:

{
  flake-file.inputs.hytale-launcher = {
    url = "github:JPyke3/hytale-launcher-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.hytale = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
