{
  flake.modules.nixos.ly = {
    services.displayManager = {
      enable = true;
      ly = {
        enable = true;
        settings.session_log = "null";
      };
    };
  };
}
