{ config, ... }:
{
  flake.modules.nixos.profile-gaming = {
    imports = with config.flake.modules.nixos; [
      steam
      heroic
      hytale
      emulation
      supertux
    ];
  };
}
