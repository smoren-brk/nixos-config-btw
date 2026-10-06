{ inputs, ... }:

{
  flake-file.inputs.vieb-nix = {
    url = "github:tejing1/vieb-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.vieb = { pkgs, ... }: {
    # environment.variables.BROWSER = "vieb";

    environment.systemPackages = [
      (inputs.vieb-nix.packagesFunc pkgs).vieb
    ];
  };

  flake.modules.homeManager.vieb = { ... }: {
    home.file.".viebrc".source = ./viebrc;
  };
}
