{
  flake.modules.nixos.zsh = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      zsh-powerlevel10k
    ];

    programs = {
      zsh = {
        enable = true;
      };
    };
  };

  flake.modules.homeManager.zsh = { config, pkgs, ... }: {
    xdg.configFile."zsh/.p10k.zsh".source = ./p10k.zsh;

    programs.zsh = {
      enable = true;
      package = null;

      dotDir = "${config.xdg.configHome}/zsh";

      fastSyntaxHighlighting.enable = true;
      autosuggestion.enable = true;

      zsh-abbr = {
        enable = true;
        abbreviations = {
          nixos-rebuild = "doas nixos-rebuild switch --flake .";
          next-gen = "doas ~/bin/diff-generations";
          ff = "fastfetch";
        };
      };

      history = {
        append = true;
        expireDuplicatesFirst = true;
        findNoDups = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        path = "${config.xdg.configHome}/zsh/hist";
        save = 10000;
        saveNoDups = true;
        share = true;
        size = 10000;
      };

      shellAliases = {
        ls = "eza --icons --group-directories-first --oneline";
        ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
      };

      initContent = ''
        bindkey '^H' backward-kill-word
        bindkey '^[[3;5~' kill-word
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word

        eval "$(zoxide init zsh --cmd cd)"
        eval "$(fzf --zsh)"
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${config.xdg.configHome}/zsh/.p10k.zsh
      '';
    };
  };
}
