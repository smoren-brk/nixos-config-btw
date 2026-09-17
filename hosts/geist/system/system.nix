{ pkgs, ... }:

{
  hardware.i2c.enable = true;

  boot = {
    loader = {
      limine.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "geist";

  time.timeZone = "Europe/Belgrade";

  users.users.jx = {
    isNormalUser = true;
    description = "JX";
    home = "/home/jx";
  };

  environment.variables.NIXOS_OZONE_WL = "1";

  services = {
    xserver.xkb.layout = "us";
    getty.autologinUser = "jx";
  };

  system.stateVersion = "26.11"; # Did you read the comment?
}
