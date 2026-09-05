{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    split-monitor-workspaces = {
      url = "github:smoren-brk/split-monitor-workspaces";
    };
  };

  outputs =
    { nixpkgs, home-manager, split-monitor-workspaces, ... }: {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit split-monitor-workspaces;
        };

        modules = [
          ./modules/hosts/geist/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
}
