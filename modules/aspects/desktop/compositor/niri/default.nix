{ inputs, config, ... }:

{
  flake-file.inputs = {
    niri = {
      url = "github:niri-wm/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.wrapper.niri = {
    settings.include = "${./_config}/config.kdl";
  };

  flake.modules.nixos.niri =
    { pkgs, lib, ... }:
    let
      niri =
        (inputs.wrappers.wrapperModules.niri.apply {
          inherit pkgs;
          imports = [ config.flake.modules.wrapper.niri ];

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
