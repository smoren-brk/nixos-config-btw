{
  flake-file.inputs = {
    self.submodules = true;

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-file.url = "github:denful/flake-file";
    import-tree.url = "github:denful/import-tree";
    wrappers.url = "github:lassulus/wrappers";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
