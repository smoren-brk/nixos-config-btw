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
          users = [ "jx" ];
        }
      ];
    };

    services.displayManager = {
      enable = true;
      ly = {
        enable = true;
        x11Support = false;
        settings = {
          auto_login_user = "jx";
          auto_login_session = "niri";
        };
      };
    };

  };
}
