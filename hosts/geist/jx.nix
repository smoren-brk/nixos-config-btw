{ config, ... }:

let
  homeManagerModules = builtins.attrValues config.flake.modules.homeManager;
in
{
  flake.modules.wrapper.git = {
    settings.user = {
      email = "sumarac@protonmail.com";
      name = "Jovan Djokic-Sumarac";
    };
  };

  flake.modules.nixos.jx =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      homeDir = config.users.users.jx.home;
      userDirs = {
        XDG_DESKTOP_DIR = "${homeDir}/user/xdg/desktop/";
        XDG_DOCUMENTS_DIR = "${homeDir}/user/docs/";
        XDG_DOWNLOAD_DIR = "${homeDir}/user/dl/";
        XDG_MUSIC_DIR = "${homeDir}/user/media/music/";
        XDG_PICTURES_DIR = "${homeDir}/user/media/pics/";
        XDG_PROJECTS_DIR = "${homeDir}/user/xdg/projects/";
        XDG_PUBLICSHARE_DIR = "${homeDir}/user/xdg/public/";
        XDG_TEMPLATES_DIR = "${homeDir}/user/xdg/templates/";
        XDG_VIDEOS_DIR = "${homeDir}/user/media/vids/";
      };
      userDirsFile = pkgs.writeText "user-dirs.dirs" (
        lib.generators.toKeyValue { } (lib.mapAttrs (_: value: ''"${value}"'') userDirs)
      );
      userDirsConf = pkgs.writeText "user-dirs.conf" "enabled=True";
    in
    {
      users.users.jx = {
        isNormalUser = true;
        description = "JX";
        home = "/home/jx";
        shell = config.programs.zsh.package;
        extraGroups = [
          "wheel"
          "doas"
        ];
      };

      environment.systemPackages = [
        pkgs.xdg-user-dirs
      ];

      home-manager.useGlobalPkgs = true;
      home-manager.users.jx.imports = homeManagerModules;
    };

  flake.modules.homeManager.jx = { config, ... }: {
    home = {
      stateVersion = "26.11";
    };

    manual.manpages.enable = false;
    programs.man.enable = false;
  };
}
