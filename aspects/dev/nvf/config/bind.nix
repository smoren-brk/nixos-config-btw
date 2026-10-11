{
  flake.modules.nixos.neovim =
    let
      keymap = mode: key: action: { inherit mode key action; };
    in
    {
      programs.nvf.settings.vim = {
        globals.mapleader = " ";
        keymaps = [
          (keymap "n" "<leader>tw" "<cmd>lua MiniTrailspace.trim()<CR>")
          (keymap "t" "<Esc>" "<C-\\><C-n>")
          (keymap "n" "<C-Space>" "<cmd>bprev<CR>")

          (keymap "v" "J" ":m '>+1<CR>gv=gv")
          (keymap "v" "K" ":m '<-2<CR>gv=gv")

          (keymap "n" "J" "mzJ`z")
          (keymap "n" "<C-d>" "<C-d>zz")
          (keymap "n" "<C-u>" "<C-u>zz")
          (keymap "n" "n" "nzzzv")
          (keymap "n" "N" "Nzzzv")

          (keymap "n" "<leader>e" "<cmd>Oil<CR>")

          (keymap "n" "<leader>o" "<cmd>update<CR> <cmd>source<CR>")
          (keymap "n" "<leader>w" "<cmd>write<CR>")
          (keymap "n" "<leader>q" "<cmd>quit<CR>")

          (keymap [ "n" "v" "x" ] "<leader>y" "\"+y")
          (keymap [ "n" "v" "x" ] "<leader>d" "\"+d")
        ];
      };
    };
}
