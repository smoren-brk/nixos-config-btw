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
      ];
    };
  };
}
