{
  flake.modules.nixos.nix = { pkgs, config, ... }: {
    nixpkgs.config.allowUnfree = true;

    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        auto-optimise-store = true;
      };

      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
      };
    };

    environment.systemPackages = [
      pkgs.nh
    ];
  };
}
