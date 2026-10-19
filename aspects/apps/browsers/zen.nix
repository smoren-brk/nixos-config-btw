{
  inputs,
  lib,
  ...
}:
let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  prefs = {
    "browser.ai.control.default" = "blocked";
    "browser.contentblocking.category" = "strict";
    "extensions.pocket.enabled" = false;
    "gfx.webrender.software" = false;
    "media.av1.enabled" = true;
    "media.ffmpeg.vaapi.enabled" = true;
    "media.hardware-video-decoding.enabled" = true;
  };

  extensions = [
    (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
    (extension "darkreader" "addon@darkreader.org")
    (extension "sponsorblock" "sponsorBlocker@ajay.app")
    (extension "ublock-origin" "uBlock0@raymondhill.net")
  ];

in
{
  flake-file.inputs.zen-browser = {
    url = "github:youwen5/zen-browser-flake/refs/pull/23/head";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.zen = { pkgs, ... }: {

    environment = {
      variables.BROWSER = "zen";

      systemPackages = [
        (pkgs.wrapFirefox
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
          {
            extraPrefs = lib.concatLines (
              lib.mapAttrsToList (
                name: value: "lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});"
              ) prefs
            );

            extraPolicies = {
              DisableTelemetry = true;
              ExtensionSettings = builtins.listToAttrs extensions;

              SearchEngines = {
                Default = "g";
                Add = [
                  {
                    Name = "YouTube";
                    URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
                    IconURL = "https://youtube.com/favicon.ico";
                    Alias = "@yt";
                  }
                  {
                    Name = "1337x";
                    URLTemplate = "https://1337x.to/search/{searchTerms}/1/";
                    IconURL = "https://1337x.to/favicon.ico";
                    Alias = "@13";
                  }
                  {
                    Name = "nixpkgs packages";
                    URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@np";
                  }
                  {
                    Name = "NixOS options";
                    URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@no";
                  }
                  {
                    Name = "NixOS Wiki";
                    URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@nw";
                  }
                  {
                    Name = "MyNixos";
                    URLTemplate = "https://mynixos.com/search?q={searchTerms}";
                    IconURL = "https://mynixos.com/favicon.ico";
                    Alias = "@mn";
                  }
                ];
              };
            };
          }
        )
      ];
    };
  };
}
