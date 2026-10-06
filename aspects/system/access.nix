{
  flake.modules.nixos.access = {
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
          cmd = "nh";
          noPass = true;
          keepEnv = false;
          runAs = "root";
        }
      ];
    };
  };
}
