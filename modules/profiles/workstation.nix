{ config, ... }:
{
  flake.modules.nixos.profile-workstation = {
    imports = with config.flake.modules.nixos; [
      theme
      niri
      ironbar
      audio
      fonts
      ly
      screenshare
      brightness
      ghostty
      fastfetch
      apps
      zen
      spotify
      mpv
      zathura
      # anki
    ];
  };
}
