{ pkgs, ... }:

{
  programs = {
    firefox.enable = true;

    hyprland = {
      withUWSM = true;
      enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };

    zsh = {
      enable = true;
      histFile = "$HOME/.config/zsh/hist";
      histSize = 5000;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;

      shellAliases = {
        ls = "eza --icons --group-directories-first --oneline";
        ff = "fastfetch";
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

        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
      '';
    };
  };

}
