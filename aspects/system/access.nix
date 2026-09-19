{
  flake.modules.nixos.access = {
    security.doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "doas" ];
          keepEnv = true;
          persist = true;
          runAs = "root";
          users = [ "jx" ];
        }
      ];
    };

    services.displayManager = {
      enable = true;
      ly = {
        enable = true;
      };
    };

  };
}
