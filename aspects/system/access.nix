{ lib, ... }:

{
  flake.modules.nixos.access = { pkgs, ... }: {
    security.doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "doas" ];
          keepEnv = false;
          persist = true;
          runAs = "root";
        }
        {
          groups = [ "doas" ];
          cmd = lib.getExe pkgs.nh;
          noPass = true;
          keepEnv = false;
          runAs = "root";
        }
      ];
    };
  };
}
