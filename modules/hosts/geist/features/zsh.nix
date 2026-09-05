{ self, inputs, ... }: {

  flake.nixosModules.zsh = { pkgs, lib, ... }: {
    programs.zsh = {
      enable = true;
    };
  };

  perSystem = { pkgs, lib, ... }: {
    packages.myZsh = inputs.wrapper-modules.wrappers.zsh.wrap {
      histFile = "$HOME/.config/zsh/hist";
      histSize = 5000;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;

      shellAliases = {
        ls = "eza --icons --group-directories-first --oneline";
        ff = "fastfetch";
        ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
      };

      promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

      setOptions = [
        "appendhistory"
        "hist_find_no_dups"
        "hist_ignore_all_dups"
        "hist_ignore_dups"
        "hist_ignore_space"
        "hist_save_no_dups"
        "sharehistory"
      ];

      interactiveShellInit = ''
        bindkey '^H' backward-kill-word
        bindkey '^[[3;5~' kill-word
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word

        eval "$(zoxide init zsh --cmd cd)"
        eval "$(fzf --zsh)"
      '';
    };
  };
}
