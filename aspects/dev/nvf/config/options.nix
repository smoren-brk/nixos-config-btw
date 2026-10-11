{
  flake.modules.nixos.neovim = {
    programs.nvf.settings.vim = {
      searchCase = "ignore";
      undoFile.enable = true;

      options = {
        autoindent = true;
        autoread = true;
        background = "dark";
        backup = false;
        compatible = false;
        cursorline = true;
        expandtab = true;
        foldlevel = 99;
        foldlevelstart = 99;
        hlsearch = true;
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
        wildmode = "longest,list";
        winborder = "rounded";
        wrap = false;
      };
    };
  };
}
