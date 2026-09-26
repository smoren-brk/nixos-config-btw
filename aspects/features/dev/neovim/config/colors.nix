{
  flake.modules.nixos.neovim = {
    programs.nixvim = {
      colorschemes.catppuccin = {
        enable = true;
        autoLoad = true;
        settings = {
          flavour = "mocha";
          custom_highlights = {
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
