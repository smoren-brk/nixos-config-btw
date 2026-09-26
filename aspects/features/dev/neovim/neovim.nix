{ inputs, ... }:

{
  flake.modules.nixos.neovim = { pkgs, ... }: {
    imports = [
      inputs.nixvim.nixosModules.nixvim
    ];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withRuby = false;

      nixpkgs.source = inputs.nixpkgs;

      globals = {
        loaded_node_provider = 0;
        loaded_ruby_provider = 0;
        loaded_perl_provider = 0;
        loaded_python_provider = 0;
      };

      enableMan = false;
    };

    environment.systemPackages = with pkgs; [
      nixfmt
      ripgrep
      tree-sitter
    ];

  };
}
