{ inputs, ... }:

{
  flake-file.inputs.spicetify-nix = {
    url = "github:Gerg-L/spicetify-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.spotify = { pkgs, theme, ... }: {
    imports = [
      inputs.spicetify-nix.nixosModules.default
    ];

    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
          aiBandBlocker
          spicyLyrics
          coverAmbience
          hidePodcasts
          keyboardShortcut
          loopyLoop
          powerBar
          romajiConvert
          sectionMarker
          shuffle
        ];
        enabledCustomApps = with spicePkgs.apps; [
          newReleases
          ncsVisualizer
        ];
        enabledSnippets = with spicePkgs.snippets; [
          pointer
        ];

        # Use Spicetify's stock layout with our shared palette.
        theme = spicePkgs.themes.default;
        customColorScheme = with theme.raw; {
          text = foreground;
          subtext = secondary;
          main = background;
          sidebar = bg0;
          player = background;
          card = surface;
          shadow = bg0;
          selected-row = secondary;
          button = accent;
          button-active = cyan;
          button-disabled = muted;
          tab-active = selection;
          notification = surface;
          notification-error = red;
          misc = border;
        };
      };

  };
}
