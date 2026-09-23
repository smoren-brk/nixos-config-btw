{
  flake.modules.nixos.brave = { pkgs, ... }: {
    environment.variables.BROWSER = "brave";

    environment.systemPackages = with pkgs; [
      brave
      brave-search-cli
    ];
  };
}
