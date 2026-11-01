{
  flake.modules.nixos.immich = {
    services.immich = {
      enable = true;
      port = 9966;
    };
  };
}
