{ inputs, ... }:
{
  flake.modules.nixos.quickshell = { pkgs, lib, theme, ... }:
    let
      palette = pkgs.writeTextDir "Palette.js" (
        ".pragma library\n"
        + lib.concatMapAttrsStringSep "\n" (name: color: "var ${name} = ${builtins.toJSON color}") theme.colors
      );
      barConfig = pkgs.symlinkJoin {
        name = "quickshell-config";
        paths = [ ./_config palette ];
      };
      shell = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.quickshell;
        binName = "quickshell";
        aliases = [ "qs" ];
        flags."--path" = toString barConfig;
      };
      qs = "${shell}/bin/qs";
    in
    {
      environment.systemPackages = [ shell ];
      local.wrappers.niri.settings = {
        spawn-at-startup = [ [ qs "--no-duplicate" ] ];
        binds."Mod+B" = {
          _attrs = { repeat = false; hotkey-overlay-title = "Cycle bar visibility"; };
          spawn = [ qs "ipc" "call" "bar" "toggle" ];
        };
        binds."Mod+D" = {
          _attrs = { repeat = false; hotkey-overlay-title = "Open application launcher"; };
          spawn = [ qs "ipc" "call" "launcher" "toggle" ];
        };
      };
    };
}
