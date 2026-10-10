{
  flake.modules.nixos.ly = {
    services.displayManager = {
      enable = true;
      ly = {
        enable = true;
      };
    };
  };
}
