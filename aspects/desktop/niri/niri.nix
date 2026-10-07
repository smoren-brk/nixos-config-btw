{ inputs, config, ... }:

{
  flake-file.inputs = {
    oniri.url = "github:Antiz96/oniri";

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
      };

      environment = {
        systemPackages = with pkgs; [
          # inputs.oniri.packages.${pkgs.stdenv.hostPlatform.system}.default
          awww
          catppuccin-cursors.mochaGreen
          grim
          slurp
          superfile
          swappy
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
