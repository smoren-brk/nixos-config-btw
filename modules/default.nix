{ inputs, ... }:

let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in
{
  imports = [
    inputs.flake-file.flakeModules.default
    inputs.flake-parts.flakeModules.modules

    ./inputs.nix

    (inputs.import-tree ./aspects)
    (inputs.import-tree ./profiles)
    (inputs.import-tree ./users)
    (inputs.import-tree ./hosts)
  ];

  systems = [ system ];
  flake-file.outputs = "flake-parts";
  flake.formatter.${system} = pkgs.nixfmt-tree;
}
