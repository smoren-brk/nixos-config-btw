{
  flake.modules.nixos.terminal-tools = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      bat
      bitwarden-cli
      broot
      btop
      btrfs-progs
      eza
      fastfetch
      fzf
      gnutar
      killall
      nix-search-tv
      tealdeer
      tree
      unzip
      vifm
      xdg-user-dirs
      zoxide
    ];
  };
}
