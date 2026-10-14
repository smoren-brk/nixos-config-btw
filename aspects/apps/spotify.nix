{ inputs, ... }:

{
  flake-file.inputs.spicetify-nix = {
    url = "github:Gerg-L/spicetify-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.spotify = { pkgs, ... }: {
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

        theme = spicePkgs.themes.catppuccin // {
          extraCommands = ''
            crudini --set Themes/catppuccin/color.ini mocha button f38ba8
            crudini --set Themes/catppuccin/color.ini mocha button-active f38ba8
            crudini --set Themes/catppuccin/color.ini mocha selected-row f38ba8
          '';
        };
        colorScheme = "mocha";
      };

  };
}
