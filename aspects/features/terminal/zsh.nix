{
  flake.modules.nixos.zsh = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      zsh-powerlevel10k
    ];

    programs = {
      zsh = {
        enable = true;
        histFile = "$HOME/.config/zsh/hist";
        histSize = 5000;
        syntaxHighlighting.enable = true;
        autosuggestions.enable = true;

        shellAliases = {
          ls = "eza --icons --group-directories-first --oneline";
          ff = "fastfetch";
          ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
          next-gen = "doas nixos-rebuild switch --flake . && doas ~/bin/diff-generations";
          flk = "nix flake update";
          list = "eza --icons --group-directories-first --oneline";
          remove = "rm";
          unmount = "umount";
          change-ownership = "chown";
          change-modifiers = "chmod";
          list-block-devices = "lsblk";
          copy = "cp";
          move = "mv";
          make-directory = "mkdir -p";
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

          bindkey -s '^N' 'nvim .^M'

          eval "$(zoxide init zsh --cmd cd)"
          eval "$(fzf --zsh)"
        '';
      };
    };
  };
}
