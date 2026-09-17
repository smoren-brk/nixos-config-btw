{
  flake.modules.nixos.terminal-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      bat
      bitwarden-cli
      btop
      btrfs-progs
      eza
      fastfetch
      fzf
      gnutar
      home-manager
      killall
      nix-search-tv
      tealdeer
      tree
      unzip
      xdg-user-dirs
      zoxide
    ];
  };
}
