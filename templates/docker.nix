{
  flake.modules.nixos.docker = {
    virtualisation.docker = {
      enable = false;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
