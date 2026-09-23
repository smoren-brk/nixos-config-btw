{
  flake.modules.nixos.firefox = {
    # environment.variables.BROWSER = "firefox";

    programs.firefox = {
      enable = true;

      preferencesStatus = "user";
      preferences = {
        "browser.nova.enabled" = true;
        "browser.startup.page" = 3;
        "browser.download.dir" = "/home/jx/user/dl";
        "browser.download.folderList" = 2;
        "browser.download.useDownloadDir" = false;

        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        "layout.css.prefers-color-scheme.content-override" = 0;

        "browser.contentblocking.category" = "standard";
        "network.dns.disablePrefetch" = true;
        "network.http.speculative-parallel-limit" = 0;
        "network.prefetch-next" = false;

        "signon.rememberSignons" = false;
        "media.eme.enabled" = true;
      };

      autoConfig = ''
        pref("sidebar.revamp", true);
        pref("sidebar.verticalTabs", true);
        pref("sidebar.main.tools", "{446900e4-71c2-419f-a6a7-df9c091e268b}");
      '';

      policies.ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          default_area = "navbar";
        };
        "addon@darkreader.org" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          default_area = "navbar";
        };
        "sponsorBlocker@ajay.app" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          default_area = "navbar";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          default_area = "navbar";
        };
      };
    };
  };
}
