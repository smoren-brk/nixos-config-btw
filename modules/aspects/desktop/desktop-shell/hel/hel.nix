{ inputs, ... }:
let
  wallpaper = ./wallpaper.jpg;
in
{
  flake-file.inputs.hel = {
    url = "github:smoren-brk/hel";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.hel = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.hel.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    environment.sessionVariables.HEL_WALLPAPER = "${wallpaper}";

    local.wrappers.niri.settings.spawn-at-startup = [
      [ "env" "HEL_WALLPAPER=${wallpaper}" "hel" ]
      [ "sh" "-c" "sleep 1 && awww img ${wallpaper}" ]
    ];
  };
}
