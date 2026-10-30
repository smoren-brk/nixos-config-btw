{
  flake.modules.nixos.terminal-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      bitwarden-cli
      btop
      btrfs-progs
      gnutar
      killall
      nix-search-tv
      tealdeer
      tree
      unzip
      xdg-user-dirs
    ];
  };
}
