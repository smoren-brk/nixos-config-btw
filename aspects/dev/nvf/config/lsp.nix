{
  flake.modules.nixos.neovim = {
    programs.nvf.settings.vim = {
      lsp = {
        enable = true;
        mappings = {
          hover = "<leader>gd";
          renameSymbol = "<leader>rn";
        };
      };

      languages = {
        nix.enable = true;
        odin.enable = true;
        lua.enable = true;
        go.enable = true;
      };

      autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
      };

      diagnostics = {
        enable = true;
        config = {
          signs = false;
          virtual_text = {
            prefix = "●";
            spacing = 2;
          };
          float = {
            focusable = false;
            style = "minimal";
            border = "rounded";
            source = "if_many";
            header = "";
            prefix = "";
          };
        };
      };
    };
  };
}
