{ inputs, ... }:

{
  flake.modules.nixos.nix = { pkgs, config, ... }: {
    nixpkgs.config.allowUnfree = true;

    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        extra-substituters = [ "https://cache.numtide.com" ];
        extra-trusted-public-keys = [
          "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        ];

        auto-optimise-store = true;
      };

      gc = {
        automatic = true;
        options = "--delete-older-than 14d";
      };
    };

    environment.systemPackages = [
      (inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.nh;
        env.NH_FLAKE = "${config.users.users.jx.home}/config/";
      })
    ];
  };
}
