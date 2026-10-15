{
  flake.modules.nixos.qutebrowser = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      qutebrowser
    ];
  };

  flake.modules.homeManager.qutebrowser = { pkgs, ... }: {
    programs.qutebrowser = {
      enable = true;
      package = null;

      quickmarks = {
        "13" = "https://1337x.to/";
        aa = "https://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20";
        gpt = "https://chatgpt.com";
        mn = "https://mynixos.com/";
        pm = "https://mail.proton.me/u/0/inbox";
        re = "https://www.reddit.com/";
        wa = "https://web.whatsapp.com/";
        yt = "https://youtube.com";
      };

      keyBindings = {
        normal = {
          M = "hint links spawn mpv {hint-url}";
          Z = "hint links spawn ghostty -e youtube-dl {hint-url}";
          t = "set-cmd-text -s :open -t";
          xb = "config-cycle statusbar.show always never";
          xt = "config-cycle tabs.show always never";
          xx = "config-cycle statusbar.show always never ;; config-cycle tabs.show always never";
        };
      };

      searchEngines = {
        DEFAULT = "https://www.google.com/search?q={}";
        re = "https://www.reddit.com/r/{}";
        yt = "https://www.youtube.com/results?search_query={}";
        "13" = "https://1337x.to/search/{}/1/";
        mn = "https://mynixos.com/search?q={}";
      };

      settings = {
        downloads.location.directory = "~/user/dl";

        tabs.show = "multiple";

        url.default_page = "ddg.gg";
        url.start_pages = [ "ddg.gg" ];

        fonts.default_family = "Source Code Pro";
        fonts.default_size = "11pt";
        fonts.completion.entry = "11pt Source Code Pro";
        fonts.debug_console = "11pt Source Code Pro";
        fonts.prompts = "default_size sans-serif";
        fonts.statusbar = "11pt Source Code Pro";

        # Qutebrowser has no built-in Tokyo Night theme.
        colors.completion.fg = "#c0caf5";
        colors.completion.odd.bg = "#1a1b26";
        colors.completion.even.bg = "#16161e";
        colors.completion.category.bg = "#16161e";
        colors.completion.category.fg = "#7aa2f7";
        colors.completion.category.border.top = "#16161e";
        colors.completion.category.border.bottom = "#16161e";
        colors.completion.item.selected.bg = "#283457";
        colors.completion.item.selected.fg = "#c0caf5";
        colors.completion.item.selected.border.top = "#283457";
        colors.completion.item.selected.border.bottom = "#283457";
        colors.completion.match.fg = "#e0af68";
        colors.completion.item.selected.match.fg = "#e0af68";
        colors.completion.scrollbar.bg = "#16161e";
        colors.completion.scrollbar.fg = "#9aa5ce";
        colors.contextmenu.menu.bg = "#1a1b26";
        colors.contextmenu.menu.fg = "#c0caf5";
        colors.contextmenu.selected.bg = "#283457";
        colors.contextmenu.selected.fg = "#c0caf5";
        colors.downloads.bar.bg = "#1a1b26";
        colors.downloads.start.bg = "#7aa2f7";
        colors.downloads.stop.bg = "#9ece6a";
        colors.downloads.error.bg = "#f7768e";
        colors.hints.bg = "#e0af68";
        colors.hints.fg = "#1a1b26";
        colors.hints.match.fg = "#f7768e";
        colors.keyhint.bg = "#16161e";
        colors.keyhint.fg = "#c0caf5";
        colors.keyhint.suffix.fg = "#e0af68";
        colors.messages.error.bg = "#1a1b26";
        colors.messages.error.fg = "#f7768e";
        colors.messages.error.border = "#f7768e";
        colors.messages.warning.bg = "#1a1b26";
        colors.messages.warning.fg = "#e0af68";
        colors.messages.warning.border = "#e0af68";
        colors.messages.info.bg = "#1a1b26";
        colors.messages.info.fg = "#7aa2f7";
        colors.messages.info.border = "#7aa2f7";
        colors.prompts.bg = "#1a1b26";
        colors.prompts.fg = "#c0caf5";
        colors.prompts.border = "1px solid #7aa2f7";
        colors.prompts.selected.bg = "#283457";
        colors.prompts.selected.fg = "#c0caf5";
        colors.statusbar.normal.bg = "#1a1b26";
        colors.statusbar.normal.fg = "#c0caf5";
        colors.statusbar.command.bg = "#1a1b26";
        colors.statusbar.command.fg = "#c0caf5";
        colors.statusbar.caret.bg = "#1a1b26";
        colors.statusbar.caret.fg = "#c0caf5";
        colors.statusbar.caret.selection.bg = "#1a1b26";
        colors.statusbar.caret.selection.fg = "#c0caf5";
        colors.statusbar.insert.bg = "#1a1b26";
        colors.statusbar.insert.fg = "#c0caf5";
        colors.statusbar.passthrough.bg = "#1a1b26";
        colors.statusbar.passthrough.fg = "#c0caf5";
        colors.statusbar.private.bg = "#1a1b26";
        colors.statusbar.private.fg = "#c0caf5";
        colors.statusbar.command.private.bg = "#1a1b26";
        colors.statusbar.command.private.fg = "#c0caf5";
        colors.statusbar.progress.bg = "#7aa2f7";
        colors.statusbar.url.fg = "#c0caf5";
        colors.statusbar.url.success.http.fg = "#9ece6a";
        colors.statusbar.url.success.https.fg = "#9ece6a";
        colors.statusbar.url.error.fg = "#f7768e";
        colors.statusbar.url.warn.fg = "#e0af68";
        colors.statusbar.url.hover.fg = "#7aa2f7";
        colors.tabs.bar.bg = "#16161e";
        colors.tabs.even.bg = "#1a1b26";
        colors.tabs.even.fg = "#9aa5ce";
        colors.tabs.odd.bg = "#1a1b26";
        colors.tabs.odd.fg = "#9aa5ce";
        colors.tabs.selected.even.bg = "#283457";
        colors.tabs.selected.even.fg = "#c0caf5";
        colors.tabs.selected.odd.bg = "#283457";
        colors.tabs.selected.odd.fg = "#c0caf5";
        colors.tabs.pinned.even.bg = "#1a1b26";
        colors.tabs.pinned.even.fg = "#9aa5ce";
        colors.tabs.pinned.odd.bg = "#1a1b26";
        colors.tabs.pinned.odd.fg = "#9aa5ce";
        colors.tabs.pinned.selected.even.bg = "#283457";
        colors.tabs.pinned.selected.even.fg = "#c0caf5";
        colors.tabs.pinned.selected.odd.bg = "#283457";
        colors.tabs.pinned.selected.odd.fg = "#c0caf5";
        colors.tabs.indicator.start = "#7aa2f7";
        colors.tabs.indicator.stop = "#9ece6a";
        colors.tabs.indicator.error = "#f7768e";

        colors.webpage.bg = "#1a1b26";
        colors.webpage.darkmode.enabled = true;
      };

    };
  };
}
