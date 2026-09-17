{
  config,
  lib,
  pkgs,
  system,
  raito,
  ...
}:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    ./system/hardware.nix
    ./system/packages.nix
    ./system/system.nix
  ];

  home-manager.users.jx = {
    imports = [
      ./../../users/jx/default.nix
    ];
  };

}
