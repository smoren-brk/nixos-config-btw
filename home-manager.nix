{
  pkgs,
  ...
}:

{
  home.stateVersion = "26.11";

  imports = [
    ./home-manager/git.nix
  ];

}
