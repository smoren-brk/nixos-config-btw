{ inputs, ... }:

{
  flake.modules.nixos.quickshell = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.qml-niri.packages.${pkgs.stdenv.hostPlatform.system}.quickshell
    ];
  };

  flake.modules.homeManager.quickshell = { config, ... }: {
    programs.quickshell = {
      enable = true;
      package = null;
    };

    xdg.configFile."quickshell".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/config/aspects/desktop/quickshell/_config";
  };
}
