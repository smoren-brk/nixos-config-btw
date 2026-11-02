{ inputs, ... }:

{
  flake-file.inputs = {
    niri = {
      url = "github:niri-wm/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.niri =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      niri =
        (inputs.wrappers.wrapperModules.niri.apply {
          inherit pkgs;
          imports = [
            (config.local.wrappers.niri or { })
          ];

          settings.include = "${./_config}/config.kdl";

          package = lib.mkForce (
            inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (_: {
              doCheck = false;
            })
          );
        }).wrapper;
    in
    {
      programs.niri = {
        enable = true;
        package = niri;
        useNautilus = false;
      };

      environment = {
        systemPackages = with pkgs; [
          awww
          bibata-cursors
          wl-clipboard-rs
          xwayland-satellite
        ];

        variables = {
          NIXOS_OZONE_WL = "1";
          XDG_CURRENT_DESKTOP = "niri";
        };
      };

    };
}
