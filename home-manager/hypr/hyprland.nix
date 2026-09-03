{ ... }:

{
  imports = [
    ./slices/bind.nix
    ./slices/decoration.nix
    ./slices/general.nix
    ./slices/monitor.nix
    ./slices/rules.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    configType = "lua";
  };

  services.hyprpaper = {
    enable = true;
    package = null;
    settings = {
      wallpaper = [
        {
          monitor = "";
          path = "/home/jx/user/dl/nix-wave.png";
        }
      ];
    };
  };
}
