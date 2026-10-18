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

            scroll-page-aware = true;
            scroll-full-overlap = 0.01;
            scroll-step = 50;

            recolor-reverse-video = true;
            recolor-keephue = true;
            render-loading = false;
          };

          extraConfig = ''
            include ${pkgs.vimPlugins.tokyonight-nvim.src}/extras/zathura/tokyonight_night.zathurarc
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
