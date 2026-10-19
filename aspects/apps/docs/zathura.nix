{ inputs, ... }:

{
  flake.modules.nixos.zathura =
    { pkgs, theme, ... }:

    let
      wrappedZathura =
        (inputs.wrappers.wrapperModules.zathura.apply {
          inherit pkgs;

          settings = with theme.colors; {
            adjust-open = "best-fit";
            pages-per-row = 1;

            scroll-page-aware = true;
            scroll-full-overlap = 0.01;
            scroll-step = 50;

            recolor-reverse-video = true;
            recolor-keephue = true;
            render-loading = false;

            default-bg = background;
            default-fg = foreground;
            completion-bg = background;
            completion-fg = foreground;
            completion-group-bg = surface;
            completion-group-fg = accent;
            completion-highlight-bg = selection;
            completion-highlight-fg = foreground;
            index-bg = background;
            index-fg = foreground;
            index-active-bg = selection;
            index-active-fg = foreground;
            inputbar-bg = background;
            inputbar-fg = foreground;
            statusbar-bg = background;
            statusbar-fg = foreground;
            notification-bg = background;
            notification-fg = foreground;
            notification-error-bg = background;
            notification-error-fg = red;
            notification-warning-bg = background;
            notification-warning-fg = yellow;
            highlight-color = accent;
            highlight-active-color = magenta;
            recolor-lightcolor = background;
            recolor-darkcolor = foreground;
          };

          extraConfig = "unmap f";

          mappings = {
            "i" = "recolor";
            "f" = "toggle_fullscreen";
            "[fullscreen] f" = "toggle_fullscreen";
          };

        }).wrapper;
    in
    {
      environment.systemPackages = [
        wrappedZathura
      ];
    };
}
