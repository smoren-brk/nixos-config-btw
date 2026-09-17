{ inputs, ... }:

{
  flake.modules.nixos.brightness = { pkgs, ... }: {
    hardware.i2c.enable = true;

    environment.systemPackages = [
      inputs.raito.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
