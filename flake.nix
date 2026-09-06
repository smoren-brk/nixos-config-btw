{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    split-monitor-workspaces.url = "github:smoren-brk/split-monitor-workspaces";
    raito.url = "github:smoren-brk/raito";
    orthos.url = "github:smoren-brk/neovim-orthos";
  };

  outputs =
    { nixpkgs, home-manager, split-monitor-workspaces, raito, orthos, ... }: {
      nixosConfigurations.geist = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit split-monitor-workspaces;
          inherit raito;
          inherit orthos;
        };

        modules = [
          ./modules/hosts/geist/default.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
}
