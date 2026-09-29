{
  flake.modules.nixos.nyxt = { pkgs, ... }: {
    # environment.variables.BROWSER = "nyxt";

    environment.systemPackages = [
      pkgs.nyxt
    ];

  };
}
