{ pkgs, split-monitor-workspaces, orthos, ... }:

{
  home = {
    stateVersion = "26.11";

    file."bin" = {
      source = ./home/bin;
      recursive = true;
    };

    sessionPath = [
      "$HOME/bin"
    ];
  };

  imports = [
    ./home/ghostty.nix
    ./home/git.nix
    ./home/hypr/hyprland.nix
    ./home/mpv.nix
    ./home/neovim.nix
    ./home/niri/niri.nix
    ./home/quickshell/qs.nix
    ./home/qutebrowser.nix
    ./home/zathura.nix
  ];
}
