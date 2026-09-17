{
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
