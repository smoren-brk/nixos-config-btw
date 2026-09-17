{
  flake.modules.nixos.nix = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nix.gc.automatic = false;

    nixpkgs.config.allowUnfree = true;
  };
}
