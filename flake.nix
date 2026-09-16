{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";

    raito.url = "github:smoren-brk/raito";
    orthos.url = "github:smoren-brk/neovim-orthos";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qml-niri = {
      url = "github:imiric/qml-niri/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };

    torlink = {
      url = "github:baairon/torlink";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { config, ... }: {
        systems = [ "x86_64-linux" ];

        imports = [
          inputs.flake-parts.flakeModules.modules
          (inputs.import-tree ./aspects)
        ];

        flake.nixosConfigurations.geist = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;

          modules = [
            ./hosts/geist/default.nix
            inputs.home-manager.nixosModules.home-manager
            config.flake.modules.nixos.neovim
            config.flake.modules.nixos.zsh
            config.flake.modules.nixos.niri

            {
              home-manager.users.jx.imports = [
                config.flake.modules.homeManager.neovim
                config.flake.modules.homeManager.niri
              ];
            }
          ];
        };
      }
    );
}
