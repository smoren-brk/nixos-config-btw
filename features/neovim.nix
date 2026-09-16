{ inputs, ... }:

{
  flake.modules.nixos.neovim = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };
  };

  flake.modules.homeManager.neovim = {
    xdg.configFile."nvim".source = inputs.orthos.lib.luaPackage;
  };
}
