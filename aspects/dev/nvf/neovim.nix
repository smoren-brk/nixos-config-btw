{ inputs, ... }:

{
  flake-file.inputs.nvf = {
    url = "github:notashelf/nvf";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.neovim = { pkgs, ... }: {
    imports = [ inputs.nvf.nixosModules.default ];

    programs.nvf = {
      enable = true;
      defaultEditor = true;
      settings.vim = {
        viAlias = false;
        vimAlias = true;

        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers.wl-copy = {
            enable = true;
            package = pkgs.wl-clipboard-rs;
          };
        };
      };
    };

    environment.systemPackages = with pkgs; [
      nixfmt
      ripgrep
      tree-sitter
    ];
  };
}
