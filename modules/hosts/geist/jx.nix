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
      lib,
      ...
    }:

    let
      homeDir = config.users.users.jx.home;
    in
    {
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

      environment = {
        variables = {
          XDG_DESKTOP_DIR = "${homeDir}/user/xdg/desktop/";
          XDG_DOCUMENTS_DIR = "${homeDir}/user/docs/";
          XDG_DOWNLOAD_DIR = "${homeDir}/user/dl/";
          XDG_MUSIC_DIR = "${homeDir}/user/media/music/";
          XDG_PICTURES_DIR = "${homeDir}/user/media/pics/";
          XDG_PROJECTS_DIR = "${homeDir}/user/xdg/projects/";
          XDG_PUBLICSHARE_DIR = "${homeDir}/user/xdg/public/";
          XDG_TEMPLATES_DIR = "${homeDir}/user/xdg/templates/";
          XDG_VIDEOS_DIR = "${homeDir}/user/media/vids/";
          NH_FLAKE = "${homeDir}/config";
          NH_OS_FLAKE = "${homeDir}/config";
        };
      };

    };
}
