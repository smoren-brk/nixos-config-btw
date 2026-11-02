{ config, ... }:
{
  flake.modules.nixos.profile-workstation = {
    imports = with config.flake.modules.nixos; [
      theme
      niri
      quickshell
      audio
      fonts
      ly
      screenshare
      brightness
      ghostty
      apps
      zen
      spotify
      mpv
      zathura
      anki
    ];
  };
}
