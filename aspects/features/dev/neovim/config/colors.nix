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
              bg = "#fab387";
            };
            CursorIM = {
              fg = "#1e1e2e";
              bg = "#fab387";
            };
            CursorLineNr.fg = "#fab387";
            lCursor = {
              fg = "#1e1e2e";
              bg = "#fab387";
            };
            TermCursor = {
              fg = "#1e1e2e";
              bg = "#fab387";
            };
            FloatBorder.fg = "#fab387";
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
