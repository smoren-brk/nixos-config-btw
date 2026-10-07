{ inputs, ... }:

{
  flake.modules.nixos.MODULE = { pkgs, ... }: {

    environment.systemPackages = [
      (inputs.wrappers.wrapperModules.WRAPPER_MODULE.apply {
        inherit pkgs;

        "FILE.txt".content = ''
          config here
        '';

      }).wrapper
    ];
  };
}
