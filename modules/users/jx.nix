{
  flake.modules.nixos.user-jx =
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
        lib.generators.toKeyValue { } (lib.mapAttrs (_: path: ''"${path}"'') userDirs)
      );
      userDirsConf = pkgs.writeText "user-dirs.conf" "enabled=False\n";
    in
    {
      # These wrappers and environment variables apply to the whole host.
      # This profile is intended for machines whose primary user is jx.
      local.wrappers.git.settings = {
        user = {
          email = "sumarac@protonmail.com";
          name = "Jovan Djokic-Sumarac";
        };
        safe.directory = "${homeDir}/config/";
      };

      users.users.jx = {
        description = "usual main user";
        home = "/home/jx";
        initialPassword = "honda nsx";
        isNormalUser = true;
        shell = config.programs.zsh.package;
        extraGroups = [
          "wheel"
          "doas"
        ];
      };

      systemd.user.tmpfiles.users.jx.rules = [
        "d %h/.config 0755 - - -"
        "L+ %h/.config/user-dirs.dirs - - - - ${userDirsFile}"
        "L+ %h/.config/user-dirs.conf - - - - ${userDirsConf}"
      ]
      ++ map (path: "d ${path} 0755 - - -") (lib.attrValues userDirs);

      environment.variables = userDirs // {
        NH_FLAKE = "${homeDir}/config";
        NH_OS_FLAKE = "${homeDir}/config";
      };
    };
}
