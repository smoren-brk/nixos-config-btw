{ pkgs, ... }:

{
  programs.firefox.enable = true;
  programs.hyprland.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.zsh = {
    enable = true;
    histFile = "$HOME/.config/zsh/hist";
    histSize = 5000;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;

    shellAliases = {
      ls = "eza --icons --group-directories-first --oneline";
      vim = "nvim";
      gti = "git";
    };

    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

    interactiveShellInit = ''
      setopt appendhistory
      setopt sharehistory
      setopt hist_ignore_space
      setopt hist_ignore_all_dups
      setopt hist_save_no_dups
      setopt hist_ignore_dups
      setopt hist_find_no_dups

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

}
