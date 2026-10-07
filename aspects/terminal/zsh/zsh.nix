{ inputs, ... }:

{
  flake.modules.nixos.zsh =
    { pkgs, ... }:
    let
      zsh =
        (inputs.wrappers.wrapperModules.zsh.apply {
          inherit pkgs;

          settings = {
            env = { };

            completion = {
              enable = true;
              init = "autoload -U compinit && compinit -D";
            };

            autoSuggestions = {
              enable = true;
              strategy = [ "history" ];
            };

            integrations = {
              fzf.enable = true;
              zoxide = {
                enable = true;
                flags = [ "--cmd cd" ];
              };
            };

            history = {
              append = true;
              expireDupsFirst = true;
              findNoDups = true;
              ignoreAllDups = true;
              ignoreDups = true;
              ignoreSpace = true;
              file = "$HOME/.config/zsh/hist";
              save = 10000;
              saveNoDups = true;
              share = true;
              size = 10000;
            };

            shellAliases = {
              ls = "eza --icons --group-directories-first --oneline";
              ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
            };
          };

          extraRC = ''
            mkdir -p "$HOME/.config/zsh"

            bindkey '^H' backward-kill-word
            bindkey '^[[3;5~' kill-word
            bindkey "^[[1;5C" forward-word
            bindkey "^[[1;5D" backward-word

            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
            source ${./p10k.zsh}
          '';
        }).wrapper;
    in
    {
      environment.systemPackages = with pkgs; [
        eza
        fastfetch
        fzf
        nix-search-tv
        zoxide
        zsh-powerlevel10k
      ];

      programs.zsh = {
        enable = true;
        package = zsh;
        enableGlobalCompInit = false;
      };
    };
}
