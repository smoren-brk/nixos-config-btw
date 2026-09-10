{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    split-monitor-workspaces.url = "github:smoren-brk/split-monitor-workspaces";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    qml-niri = {
      url = "github:imiric/qml-niri/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
    raito.url = "github:smoren-brk/raito";
    orthos.url = "github:smoren-brk/neovim-orthos";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }: {
      nixosConfigurations.geist = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = inputs;

        modules = [
          ./modules/hosts/geist/default.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
}
