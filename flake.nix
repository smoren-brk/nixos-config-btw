{
  description = "Geist NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    split-monitor-workspaces = {
      url = "github:smoren-brk/split-monitor-workspaces";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    { inherit inputs; }
    (inputs.import-tree ./modules);

  # outputs =
  #   {
  #     nixpkgs,
  #     home-manager,
  #     split-monitor-workspaces,
  #     ...
  #   }:
  #   {
  #     nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
  #       system = "x86_64-linux";
  #
  #       specialArgs = {
  #         inherit split-monitor-workspaces;
  #       };
  #
  #       modules = [
  #         ./configuration.nix
  #         home-manager.nixosModules.home-manager
  #       ];
  #     };
  #   };
}
