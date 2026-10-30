{
  flake.modules.nixos.nix = { pkgs, config, ... }: {
    nixpkgs.config.allowUnfree = true;

    nix = {
      channel.enable = false;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "auto-allocate-uids"
          "pipe-operators"
        ];

        auto-optimise-store = true;
        keep-going = true;
        warn-dirty = false;
        accept-flake-config = false;
        use-xdg-base-directories = true;
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
