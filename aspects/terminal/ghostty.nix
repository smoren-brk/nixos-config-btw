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
            cursor-color = "#94e2d5";
            cursor-text = "#1e1e2e";
            font-family = "Hasklug Nerd Font";
            quit-after-last-window-closed = false;
            selection-background = "#94e2d5";
            selection-foreground = "#1e1e2e";
            theme = "Catppuccin Mocha";
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
