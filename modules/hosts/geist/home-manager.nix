{ pkgs
, split-monitor-workspaces
, ...
}:

{
  home = {
    stateVersion = "26.11";

    file."bin" = {
      source = ./home-manager/bin;
      recursive = true;
    };

    sessionPath = [
      "$HOME/bin"
    ];
  };

  imports = [
    ./home-manager/ghostty.nix
    ./home-manager/git.nix
    ./home-manager/hypr/hyprland.nix
    ./home-manager/mpv.nix
    ./home-manager/quickshell/qs.nix
    ./home-manager/qutebrowser.nix
    ./home-manager/zathura.nix
  ];
}
