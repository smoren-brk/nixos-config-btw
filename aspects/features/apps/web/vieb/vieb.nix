{ inputs, ... }:

{
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
