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
              bg = "#a6e3a1";
            };
            CursorIM = {
              fg = "#1e1e2e";
              bg = "#a6e3a1";
            };
            CursorLineNr.fg = "#a6e3a1";
            lCursor = {
              fg = "#1e1e2e";
              bg = "#a6e3a1";
            };
            TermCursor = {
              fg = "#1e1e2e";
              bg = "#a6e3a1";
            };
            FloatBorder.fg = "#a6e3a1";
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
