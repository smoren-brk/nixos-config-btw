{
  pkgs,
  ...
}:

{
  programs.qutebrowser = {
    enable = true;
    package = null;

    quickmarks = {
      yt = "https://youtube.com";
      pm = "https://mail.proton.me/u/0/inbox";
      aa = "https://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20";
      "13" = "https://1337x.to/";
    };

    keyBindings = {
      normal = {
        "M" = "hint links spawn mpv {hint-url}";
        "Z" = "hint links spawn ghostty -e youtube-dl {hint-url}";
        "t" = "set-cmd-text -s :open -t";
        "xb" = "config-cycle statusbar.show always never";
        "xt" = "config-cycle tabs.show always never";
        "xx" = "config-cycle statusbar.show always never ;; config-cycle tabs.show always never";
      };
    };

    searchEngines = {
      DEFAULT = "https://www.google.com/search?q={}";
      re = "https://www.reddit.com/r/{}";
      yt = "https://www.youtube.com/results?search_query={}";
      "13" = "https://1337x.to/search/{}/1/";
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

      colors.webpage.bg = "#282828";
    };
  };
}
