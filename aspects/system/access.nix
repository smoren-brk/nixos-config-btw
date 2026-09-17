{
  flake.modules.nixos.access = {
    users.users.jx.extraGroups = [
      "wheel"
      "doas"
    ];

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
  };
}
