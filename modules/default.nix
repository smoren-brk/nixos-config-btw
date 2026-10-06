{ inputs, ... }:
{
  imports = [
    inputs.flake-file.flakeModules.default
    inputs.flake-parts.flakeModules.modules

    ./inputs.nix
    ../hosts/geist

    (inputs.import-tree ../aspects/apps)
    (inputs.import-tree ../aspects/desktop)
    (inputs.import-tree ../aspects/dev)
    (inputs.import-tree ../aspects/system)
    (inputs.import-tree ../aspects/terminal)
  ];

  systems = [ "x86_64-linux" ];
  flake-file.outputs = "flake-parts";
}
