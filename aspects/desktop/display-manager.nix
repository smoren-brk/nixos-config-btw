{
  flake.modules.nixos.ly = {
    services.displayManager = {
      enable = true;
      ly = {
        enable = true;
        x11Support = false;
      };
    };
  };
}
