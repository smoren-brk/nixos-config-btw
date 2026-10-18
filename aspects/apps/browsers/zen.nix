{ inputs, ... }:

{
  flake-file.inputs.zen-browser = {
    url = "github:youwen5/zen-browser-flake/refs/pull/23/head";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.zen-browser = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
