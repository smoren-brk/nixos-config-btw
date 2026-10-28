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
    ../hosts/geist

    (inputs.import-tree ../aspects/apps)
    (inputs.import-tree ../aspects/desktop)
    (inputs.import-tree ../aspects/development)
    (inputs.import-tree ../aspects/system)
    (inputs.import-tree ../aspects/terminal)
  ];

  systems = [ system ];
  flake-file.outputs = "flake-parts";
  flake.formatter.${system} = pkgs.nixfmt-tree;
}
