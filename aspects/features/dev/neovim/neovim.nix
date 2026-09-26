{ inputs, ... }:

{
  flake.modules.nixos.neovim = { pkgs, ... }: {
    imports = [
      inputs.nixvim.nixosModules.nixvim
    ];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      nixpkgs.source = inputs.nixpkgs;
    };

    environment.systemPackages = with pkgs; [
      nixfmt
      prettier
      ripgrep
      tree-sitter
    ];

  };
}
