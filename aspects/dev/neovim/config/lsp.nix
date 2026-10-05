{
  flake.modules.nixos.neovim =
    { config, ... }:
    let
      inherit (config.lib.nixvim) mkRaw toLuaObject;
    in
    {
      programs.nixvim = {
        plugins = {
          lspconfig.enable = true;
          friendly-snippets.enable = true;

          blink-cmp = {
            enable = true;
            callSetup = false;
            settings = {
              keymap = {
                preset = "enter";
                "<S-Tab>" = [
                  "select_prev"
                  "fallback"
                ];
                "<Tab>" = [
                  "select_next"
                  "fallback"
                ];
                "<C-e>" = false;
                "<C-s>" = [
                  (mkRaw "function(cmp) cmp.show({ providers = { 'snippets' } }) end")
                ];
              };
              appearance.nerd_font_variant = "normal";
              completion.documentation.auto_show = true;
              sources.default = [
                "lsp"
                "path"
                "snippets"
                "buffer"
              ];
            };
          };
        };

        extraConfigLua = ''
          require('blink.cmp').setup(${toLuaObject config.programs.nixvim.plugins.blink-cmp.settings})
        '';

        lsp.servers = {
          "*".config.capabilities = mkRaw "require('blink.cmp').get_lsp_capabilities()";
          nil_ls.enable = true;
          ols.enable = true;
        };

        diagnostic.settings = {
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
}
