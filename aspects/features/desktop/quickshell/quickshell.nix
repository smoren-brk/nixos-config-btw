{ inputs, ... }:

{
  flake.modules.nixos.quickshell = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.qml-niri.packages.${pkgs.stdenv.hostPlatform.system}.quickshell
    ];
  };

  flake.modules.homeManager.quickshell = { ... }: {
    programs.quickshell = {
      enable = true;
      package = null;
    };

    xdg.configFile."quickshell".source = ./_config;
  };
}
