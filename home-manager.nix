{
  pkgs,
  ...
}:

{
  home.stateVersion = "26.11";

  imports = [
    ./home-manager/ghostty.nix
    ./home-manager/git.nix
    ./home-manager/zathura.nix
  ];
}
