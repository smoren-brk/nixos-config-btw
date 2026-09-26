{
  flake.modules.nixos.neovim = {
    programs.nixvim = {
      lsp.servers = {
        nil_ls.enable = true;
        ols.enable = true;
        lua_ls.enable = true;
        pylsp.enable = true;
      };
    };
  };
}
