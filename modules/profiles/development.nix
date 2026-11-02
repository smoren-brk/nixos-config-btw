{ config, ... }:
{
  flake.modules.nixos.profile-development = {
    imports = with config.flake.modules.nixos; [
      git
      neovim
      development-tools
      ai
    ];
  };
}
