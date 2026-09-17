{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../users/jx.nix
  ];

  boot = {
    loader = {
      limine.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "geist";
  time.timeZone = "Europe/Belgrade";

  services = {
    xserver.xkb.layout = "us";
    getty.autologinUser = "jx";
  };

  system.stateVersion = "26.11";
}
