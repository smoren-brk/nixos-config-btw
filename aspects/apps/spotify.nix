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

        theme = spicePkgs.themes.tokyoNight;
        colorScheme = "Night";
      };

  };
}
