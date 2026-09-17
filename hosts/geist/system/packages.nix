{
  pkgs,
  raito,
  torlink,
  ...
}:

let
  vendoredPackages = [
    raito.packages.${pkgs.stdenv.hostPlatform.system}.default
    torlink.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  waylandUtils = with pkgs; [
    awww
    grim
    slurp
    swappy
    wl-clipboard-rs
    xwayland-satellite
  ];
in
{
  environment.systemPackages = vendoredPackages ++ waylandUtils;
}
