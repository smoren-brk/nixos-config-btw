{
  flake.modules.nixos.host-loki = {
    networking = {
      networkmanager.enable = false;
      useDHCP = true;
    };
  };
}
