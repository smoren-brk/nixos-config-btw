{ inputs, ... }:

{
  flake-file.inputs.determinate = {
    url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
  };

  flake.modules.nixos.determinate = { pkgs, config, ... }: {
    imports = [
      inputs.determinate.nixosModules.default
    ];

    nix = {
      settings = {
        extra-substituters = [ "https://install.determinate.systems" ];
        extra-trusted-public-keys = [
          "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
        ];
      };
    };

  };
}
