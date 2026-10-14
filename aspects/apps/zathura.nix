{ inputs, ... }:

{
  flake.modules.nixos.zathura =
    { pkgs, ... }:

    let
      wrappedZathura =
        (inputs.wrappers.wrapperModules.zathura.apply {
          inherit pkgs;

          settings = {
            adjust-open = "best-fit";
            pages-per-row = 1;

            default-bg = "#1e1e2e";
            default-fg = "#cdd6f4";
            completion-bg = "#313244";
            completion-fg = "#cdd6f4";
            completion-highlight-bg = "#f38ba8";
            completion-highlight-fg = "#1e1e2e";
            completion-group-bg = "#181825";
            completion-group-fg = "#cdd6f4";
            statusbar-bg = "#11111b";
            statusbar-fg = "#cdd6f4";
            inputbar-bg = "#1e1e2e";
            inputbar-fg = "#cdd6f4";
            notification-bg = "#1e1e2e";
            notification-fg = "#cdd6f4";
            notification-error-bg = "#1e1e2e";
            notification-error-fg = "#f38ba8";
            notification-warning-bg = "#1e1e2e";
            notification-warning-fg = "#f9e2af";
            index-bg = "#1e1e2e";
            index-fg = "#cdd6f4";
            index-active-bg = "#f38ba8";
            index-active-fg = "#1e1e2e";
            highlight-color = "rgba(147,153,178,0.3)";
            highlight-active-color = "rgba(243,139,168,0.3)";
            highlight-fg = "#cdd6f4";

            scroll-page-aware = true;
            scroll-full-overlap = 0.01;
            scroll-step = 50;

            recolor-lightcolor = "#1e1e2e";
            recolor-darkcolor = "#cdd6f4";
            recolor-reverse-video = true;
            recolor-keephue = true;
            render-loading = false;
          };

          extraConfig = ''
            unmap f
          '';

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
