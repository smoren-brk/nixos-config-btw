{
  flake.modules.nixos.host-loki = {
    local.wrappers.niri.settings.extraConfig = ''
      include "${./outputs.kdl}"
    '';
  };
}
