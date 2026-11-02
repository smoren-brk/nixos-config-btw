{ config, ... }:
{
  flake.modules.nixos.profile-base = {
    imports = with config.flake.modules.nixos; [
      wrapper-options
      zsh
      nix
      determinate
      access
      networking
      terminal-tools
      ssh
    ];
  };
}
