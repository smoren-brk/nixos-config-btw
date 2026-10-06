{
  flake.modules.nixos.nix = { pkgs, ... }: {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-substituters = [ "https://cache.numtide.com" ];
      extra-trusted-public-keys = [
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];
    };

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
