{ pkgs, ... }:

{
  imports = [
    ./config/bind.nix
    ./config/colors.nix
    ./config/lsp.nix
    ./config/options.nix
    ./config/plugins.nix
  ];

  vim = {
    extraPackages = [
      pkgs.ripgrep
      pkgs.tree-sitter
    ];

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
}
