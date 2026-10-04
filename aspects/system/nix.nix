{
  flake.modules.nixos.nix = { pkgs, ... }: {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    environment = {
      systemPackages = with pkgs; [
        nh
      ];
      sessionVariables = {
        FLAKE = "/home/jx/config/";
      };
    };

    nix.gc.automatic = false;
    nixpkgs.config.allowUnfree = true;
  };
}
