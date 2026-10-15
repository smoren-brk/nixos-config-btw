{ inputs, ... }:

{
  flake-file.inputs.vieb-nix = {
    url = "github:tejing1/vieb-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.vieb = { pkgs, ... }: {
    # environment.variables.BROWSER = "vieb";

    environment.systemPackages = [
      (inputs.vieb-nix.packagesFunc pkgs).vieb
    ];
  };

  flake.modules.homeManager.vieb = { ... }: {
    home.file.".viebrc".source = ./viebrc;
    # Vieb loads custom themes from its colors directory.
    home.file.".vieb/colors/tokyonight.css".text = ''
      :root {
        --bg: #1a1b26;
        --fg: #c0caf5;
        --tab-background: #16161e;
        --tab-suspended: #15161e;
        --visible-tab: #283457;
        --tab-split: #7aa2f7;
        --tab-audio: #73daca;
        --tab-muted: #565f89;
        --tab-muted-playing: #bb9af7;
        --tab-crashed: #f7768e;
        --tab-scrollbar: #414868;
        --mode-normal-fg: var(--fg);
        --mode-command-fg: #7aa2f7;
        --mode-insert-fg: #9ece6a;
        --mode-follow-fg: #e0af68;
        --mode-explore-fg: #73daca;
        --mode-search-fg: #bb9af7;
        --mode-pointer-fg: #7dcfff;
        --mode-visual-fg: #bb9af7;
        --url-default: #9aa5ce;
        --url-search: #e0af68;
        --url-searchwords: #bb9af7;
        --url-url: #7aa2f7;
        --url-suggest: #9ece6a;
        --url-file: #73daca;
        --url-invalid: #f7768e;
        --suggestions-bg: #16161e;
        --suggestions-border: #414868;
        --suggestions-selected: #283457;
        --suggestions-searchwords: #e0af68;
        --suggestions-url: #7aa2f7;
        --suggestions-file: #73daca;
        --notification-border: #414868;
        --notification-date: #9aa5ce;
        --notification-permission: #bb9af7;
        --notification-error: #f7768e;
        --notification-warning: #e0af68;
        --notification-info: #7aa2f7;
        --notification-success: #9ece6a;
        --link-color: #7aa2f7;
        --scrollbar-bg: #16161e;
        --scrollbar-thumb: #414868;
        --button-disabled: #565f89;
        --code-fg: #c0caf5;
        --code-bg: #16161e;
        --code-command: #bb9af7;
        --placeholder-text: #9aa5ce;
        --special-page-element-bg: #24283b;
        --special-page-element-border: #414868;
        --input-unfocused: #414868;
        --input-focused: #7aa2f7;
        --download-progress-fg: #7aa2f7;
        --download-progress-bg: #24283b;
      }
    '';
  };
}
