{ inputs, ... }:

{
  flake.modules.nixos.quickshell = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      nerd-fonts._0xproto
      noto-fonts
    ];

    environment.systemPackages = [
      inputs.qml-niri.packages.${pkgs.stdenv.hostPlatform.system}.quickshell
      inputs.raito.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.python3
    ];
  };

  flake.modules.homeManager.quickshell = {
    programs.quickshell = {
      enable = true;
      package = null;
    };

    xdg.configFile."quickshell".source = ./_config;
  };
}
