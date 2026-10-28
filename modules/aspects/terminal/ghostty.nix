{ inputs, ... }:

{
  flake.modules.nixos.ghostty =
    { pkgs, theme, ... }:

    let
      ghostty =
        (inputs.wrappers.wrapperModules.ghostty.apply {
          inherit pkgs;

          settings = {
            theme = theme.ghostty;
            background-opacity = 0.75;
            confirm-close-surface = false;
            font-family = "Hasklug Nerd Font";
            quit-after-last-window-closed = false;
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
