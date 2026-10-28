{ inputs, ... }:

{
  flake-file.inputs.raito.url = "github:smoren-brk/raito";

  flake.modules.nixos.brightness = { pkgs, ... }: {
    hardware.i2c.enable = true;

    environment.systemPackages = [
      inputs.raito.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
