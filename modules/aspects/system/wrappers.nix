{
  flake.modules.nixos.wrapper-options =
    { lib, ... }:
    {
      options.local.wrappers = lib.mkOption {
        type = lib.types.attrsOf lib.types.deferredModule;
        default = { };
        description = "Host-scoped additions to shared application wrappers.";
      };
    };
}
