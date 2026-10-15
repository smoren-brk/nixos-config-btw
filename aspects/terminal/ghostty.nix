{ inputs, ... }:

{
  flake.modules.nixos.ghostty =
    { pkgs, ... }:

    let
      ghostty =
        (inputs.wrappers.wrapperModules.ghostty.apply {
          inherit pkgs;

          settings = {
            background-opacity = 0.55;
            confirm-close-surface = false;
            font-family = "Hasklug Nerd Font";
            quit-after-last-window-closed = false;
            theme = "TokyoNight Night";
            window-padding-x = 20;
            window-padding-y = 20;
          };

        }).wrapper;
    in
    {
      fonts.packages = [ pkgs.nerd-fonts.hasklug ];

      environment.systemPackages = [
        ghostty
      ];
    };
}
