{
  flake.modules.nixos.nix = { config, pkgs, ... }: {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    environment = {
      systemPackages = with pkgs; [
        nh
      ];
      sessionVariables = {
        NH_FLAKE = "${config.users.users.jx.home}/config/";
      };
    };

    nix.gc.automatic = false;
    nixpkgs.config.allowUnfree = true;
  };
}
