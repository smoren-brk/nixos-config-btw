{ inputs, ... }:

{
  flake-file.inputs.neovf = {
    url = "github:smoren-brk/neovf";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.neovim = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      inputs.neovf.packages.${pkgs.stdenv.hostPlatform.system}.default
      nixfmt
      ripgrep
      tree-sitter
      wl-clipboard-rs
    ];
  };
}

