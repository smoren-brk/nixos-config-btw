{
  config,
  pkgs,
  split-monitor-workspaces,
  ...
}:

{
  home = {
    stateVersion = "26.11";

    file."bin" = {
      source = ./home/bin;
      recursive = true;
    };
  };

  imports = [
    ./home/ghostty.nix
    ./home/ssh.nix
  ];

  manual.manpages.enable = false;
  programs.man.enable = false;

  xdg = {
    enable = true;
    binHome = "${config.home.homeDirectory}/bin/";
    localBinInPath = true;

    userDirs = {
      enable = true;
      package = null;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/user/xdg/desktop/";
      documents = "${config.home.homeDirectory}/user/docs/";
      download = "${config.home.homeDirectory}/user/dl/";
      music = "${config.home.homeDirectory}/user/media/music/";
      pictures = "${config.home.homeDirectory}/user/media/pics/";
      projects = "${config.home.homeDirectory}/user/xdg/projects/";
      publicShare = "${config.home.homeDirectory}/user/xdg/public/";
      templates = "${config.home.homeDirectory}/user/xdg/templates/";
      videos = "${config.home.homeDirectory}/user/media/vids/";
    };
  };
}
