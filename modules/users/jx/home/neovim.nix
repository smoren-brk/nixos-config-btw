{ orthos, ... }:

{
  xdg.configFile."nvim".source = orthos.lib.luaPackage;
}
