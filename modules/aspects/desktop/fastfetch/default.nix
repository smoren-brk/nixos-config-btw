{ inputs, ... }:

{
  flake.modules.nixos.fastfetch =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        (inputs.wrappers.wrapperModules.fastfetch.apply {
          inherit pkgs;

          "config.jsonc".path = "${./config.jsonc}";
        }).wrapper
      ];
    };
}
