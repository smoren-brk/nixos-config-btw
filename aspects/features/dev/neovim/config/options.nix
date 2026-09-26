{
  flake.modules.nixos.neovim = {
    programs.nixvim.opts = {
      autoindent = true;
      autoread = true;
      background = "dark";
      backup = false;
      clipboard = "unnamedplus";
      compatible = false;
      cursorline = true;
      expandtab = true;
      foldlevel = 99;
      foldlevelstart = 99;
      hlsearch = true;
      ignorecase = true;
      inccommand = "split";
      incsearch = true;
      list = true;
      mouse = "v";
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      showmatch = true;
      signcolumn = "yes";
      smartindent = true;
      smarttab = false;
      softtabstop = 4;
      splitbelow = true;
      splitkeep = "screen";
      splitright = true;
      startofline = false;
      swapfile = false;
      tabstop = 4;
      termguicolors = true;
      ttyfast = true;
      undofile = true;
      wildmode = "longest,list";
      winborder = "rounded";
      wrap = false;
    };
  };
}
