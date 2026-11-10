{
  flake.modules.nixos.host-loki = {
    networking = {
      networkmanager.enable = true;
    };
  };
}
