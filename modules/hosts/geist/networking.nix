{
  flake.modules.nixos.networking = {
    networking = {
      networkmanager.enable = false;
      useDHCP = true;
    };
  };
}
