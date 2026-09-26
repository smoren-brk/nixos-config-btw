{
  flake.modules.nixos.neovim =
    { config, ... }:
    let
      inherit (config.lib.nixvim) mkRaw;
      keymap = mode: key: action: {
        inherit mode key action;
        options.noremap = true;
      };
    in
    {
      programs.nixvim = {
        globals.mapleader = " ";

        keymaps = [
          (keymap "n" "<leader>gd" (mkRaw "vim.lsp.buf.hover"))
          (keymap "n" "<leader>tw" (mkRaw "function() MiniTrailspace.trim() end"))

          (keymap "t" "<Esc>" "<C-\\><C-n>")
          (keymap "n" "<C-Space>" "<cmd>bprev<CR>")

          (keymap "v" "J" ":m '>+1<CR>gv=gv")
          (keymap "v" "K" ":m '<-2<CR>gv=gv")

          (keymap "n" "J" "mzJ`z")
          (keymap "n" "<C-d>" "<C-d>zz")
          (keymap "n" "<C-u>" "<C-u>zz")
          (keymap "n" "n" "nzzzv")
          (keymap "n" "N" "Nzzzv")

          (keymap "n" "<leader>cc" "<cmd>CodexToggle<CR>")

          (keymap "n" "<leader>e" "<cmd>Oil<CR>")
          (keymap "n" "<leader>lf" (mkRaw "vim.lsp.buf.format"))

          (keymap "n" "<leader>o" "<cmd>update<CR> <cmd>source<CR>")
          (keymap "n" "<leader>w" "<cmd>write<CR>")
          (keymap "n" "<leader>q" "<cmd>quit<CR>")

          (keymap [ "n" "v" "x" ] "<leader>y" "\"+y")
          (keymap [ "n" "v" "x" ] "<leader>d" "\"+d")
        ];
      };
    };
}
