{ config, lib, pkgs, system, raito, orthos, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    ./system/hardware.nix
    ./system/packages.nix
    ./system/programs.nix
    ./system/system.nix
  ];

  home-manager.users.jx = {
    imports = [
      ./../../users/jx/default.nix
    ];

    _module.args = {
      inherit orthos;
    };
  };

}
