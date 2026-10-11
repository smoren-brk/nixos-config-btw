{
  flake.modules.nixos.neovim.programs.nvf.settings.vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = true;
    };

    highlight =
      let
        cursor = {
          fg = "#1e1e2e";
          bg = "#94e2d5";
        };
      in
      {
        Cursor = cursor;
        CursorIM = cursor;
        lCursor = cursor;
        TermCursor = cursor;
        CursorLineNr.fg = "#94e2d5";
        FloatBorder = {
          fg = "#94e2d5";
          bg = "none";
        };
        Pmenu.bg = "none";
      };
  };
}
