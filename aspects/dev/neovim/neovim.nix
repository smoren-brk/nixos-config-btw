{ inputs, ... }:

{
  flake.modules.nixos.neovim = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    environment.systemPackages = with pkgs; [
      nil
      nixfmt
      ols
      prettier
      ripgrep
      tree-sitter
    ];

  };

  flake.modules.homeManager.neovim = { config, ... }: {
    xdg.configFile."nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/aspects/dev/neovim/_config";
  };
}
