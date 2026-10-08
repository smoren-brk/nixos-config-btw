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
      pkgs,
      ...
    }:
    let
      homeDir = config.users.users.jx.home;
      userDirsFile = pkgs.writeText "user-dirs.dirs" ''
        XDG_DESKTOP_DIR="${homeDir}/user/xdg/desktop/"
        XDG_DOCUMENTS_DIR="${homeDir}/user/docs/"
        XDG_DOWNLOAD_DIR="${homeDir}/user/dl/"
        XDG_MUSIC_DIR="${homeDir}/user/media/music/"
        XDG_PICTURES_DIR="${homeDir}/user/media/pics/"
        XDG_PROJECTS_DIR="${homeDir}/user/xdg/projects/"
        XDG_PUBLICSHARE_DIR="${homeDir}/user/xdg/public/"
        XDG_TEMPLATES_DIR="${homeDir}/user/xdg/templates/"
        XDG_VIDEOS_DIR="${homeDir}/user/media/vids/"
      '';
      userDirsConf = pkgs.writeText "user-dirs.conf" ''
        enabled=True
      '';
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

      systemd.tmpfiles.rules = [
        "d ${homeDir}/.config 0755 jx ${config.users.users.jx.group} - -"
        "L+ ${homeDir}/.config/user-dirs.dirs - jx ${config.users.users.jx.group} - ${userDirsFile}"
        "L+ ${homeDir}/.config/user-dirs.conf - jx ${config.users.users.jx.group} - ${userDirsConf}"
      ];
    };
}
