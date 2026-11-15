{ lib, pkgs, ... }:
{
  vim = {
    # Nightfox is not in this nvf version's built-in theme registry.
    theme.enable = false;
    startPlugins = [ pkgs.vimPlugins.nightfox-nvim ];
    luaConfigRC.theme = lib.nvim.dag.entryBefore [ "pluginConfigs" "lazyConfigs" ] ''
      require("nightfox").setup({ options = { transparent = true } })
      vim.cmd.colorscheme("carbonfox")
    '';
  };
}
