{
  flake.modules.nixos.neovim = {
    programs.nixvim = {
      colorschemes.catppuccin = {
        enable = true;
        autoLoad = true;
        settings = {
          flavour = "mocha";
          custom_highlights = {
            Cursor = {
              fg = "#1e1e2e";
              bg = "#94e2d5";
            };
            CursorIM = {
              fg = "#1e1e2e";
              bg = "#94e2d5";
            };
            CursorLineNr.fg = "#94e2d5";
            lCursor = {
              fg = "#1e1e2e";
              bg = "#94e2d5";
            };
            TermCursor = {
              fg = "#1e1e2e";
              bg = "#94e2d5";
            };
            FloatBorder.fg = "#94e2d5";
            Normal.bg = "none";
            NormalFloat.bg = "none";
            FloatBorder.bg = "none";
            Pmenu.bg = "none";
          };
        };
      };
    };
  };
}
