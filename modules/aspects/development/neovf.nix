{ inputs, config, ... }:

{
  flake-file.inputs.nvf = {
    url = "github:notashelf/nvf";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.packages = inputs.nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (system: {
    neovf =
      (inputs.nvf.lib.neovimConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [ ../../packages/noevf/neovim.nix ];
      }).neovim;
  });

  flake.modules.nixos.neovim = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      config.flake.packages.${pkgs.stdenv.hostPlatform.system}.neovf

      ripgrep
      tree-sitter
    ];
  };
}
