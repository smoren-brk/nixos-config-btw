{
  flake.modules.nixos.nix = { pkgs, ... }: {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    environment.systemPackages = with pkgs; [
      nh
    ];

    nix.gc.automatic = false;
    nixpkgs.config.allowUnfree = true;
  };

  flake.modules.homeManager.nix = { config, ... }: {
    home.sessionVariables.NH_FLAKE = "${config.home.homeDirectory}/config/";
  };
}
