{
  pkgs,
  ...
}:

{
  programs.zathura = {
    enable = true;
    package = null;

    options = {
      adjust-open = "best-fit";
      pages-per-row = 1;
      scroll-page-aware = true;
      scroll-full-overlap = 0.01;
      scroll-step = 50;

      recolor-lightcolor = "rgba(0,0,0,0)";
      recolor-darkcolor = "#E0E0E0";
      recolor-reverse-video = true;
      recolor-keephue = true;

      render-loading = false;
    };

    extraConfig = ''
      unmap f
    '';

    mappings = {
      i = "recolor";
      f = "toggle_fulscreen";
      "[fullscreen] f" = "toggle_fulscreen";
    };
  };
}
