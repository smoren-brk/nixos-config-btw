{ inputs, ... }:

{
  flake-file.inputs.ironbar = {
    url = "github:JakeStanger/ironbar";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.ironbar = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.ironbar.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  };
}
