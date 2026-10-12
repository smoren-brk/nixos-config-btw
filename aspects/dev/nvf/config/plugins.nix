{
  flake.modules.nixos.neovim = { pkgs, ... }: {
    programs.nvf.settings.vim = {
      utility = {
        diffview-nvim.enable = true;
        oil-nvim.enable = true;
      };

      git.gitsigns.enable = true;

      mini = {
        cursorword.enable = true;
        starter.enable = true;
        trailspace.enable = true;
      };

      visuals = {
        nvim-web-devicons.enable = true;
        twilight-nvim.enable = true;
        rainbow-delimiters.enable = true;
      };

      languages.markdown = {
        enable = true;
        lsp.enable = false;
        extensions.markview-nvim.enable = true;
      };

      treesitter = {
        enable = true;
        fold = true;
        grammars = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [
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

      statusline.lualine = {
        enable = true;
        setupOpts.options = {
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
        extensions = [
          {
            name = "fzf";
            packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
          }
        ];
        setupOpts = {
          defaults.file_ignore_patterns = [ ];
          pickers.find_files.find_command = [
            "rg"
            "--files"
            "--hidden"
            "-g"
            "!.git"
          ];
        };
        mappings = {
          gitFiles = "<C-p>";
          findFiles = "<leader>ff";
          buffers = "<leader>fb";
          helpTags = "<leader>fh";
          liveGrep = "<leader>fg";
          gitStatus = "<leader>fs";
        };
      };

      ui = {
        noice.enable = true;
        # ui2.enable = true;
      };
    };
  };
}
