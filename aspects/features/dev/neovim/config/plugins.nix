{
  flake.modules.nixos.neovim = { config, ... }: {
    programs.nixvim = {
      plugins = {
        diffview.enable = true;
        gitsigns.enable = true;
        markview.enable = true;
        mini-cursorword.enable = true;
        mini-starter.enable = true;
        mini-trailspace.enable = true;
        oil.enable = true;

        treesitter = {
          enable = true;
          highlight.enable = true;
          indent.enable = true;
          folding.enable = true;
          grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
            bash
            c
            c_sharp
            cpp
            json
            lua
            markdown
            markdown_inline
            nix
            odin
            python
            rust
            yaml
          ];
        };

        lualine = {
          enable = true;
          settings.options = {
            section_separators = {
              left = "";
              right = "";
            };
            component_separators = {
              left = "";
              right = "";
            };
          };
        };

        telescope = {
          enable = true;
          extensions.fzf-native.enable = true;

          settings.pickers.find_files.find_command = [
            "rg"
            "--files"
            "--hidden"
            "-g"
            "!.git"
          ];

          keymaps = {
            "<C-p>" = {
              action = "git_files";
              options.desc = "Telescope Git Files";
            };
            "<leader>ff" = "find_files";
            "<leader>fb" = "buffers";
            "<leader>fh" = "help_tags";
            "<leader>fg" = "live_grep";
            "<leader>fs" = "git_status";
          };
        };
        web-devicons.enable = true;
      };
    };
  };
}
