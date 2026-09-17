{ config, ... }:

{
  flake.modules.nixos.jx = { pkgs, ... }: {
    users.users.jx = {
      isNormalUser = true;
      description = "JX";
      home = "/home/jx";
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "doas"
      ];
    };

    home-manager.users.jx.imports = builtins.attrValues config.flake.modules.homeManager;
  };

  flake.modules.homeManager.jx = { config, ... }: {
    home = {
      stateVersion = "26.11";

      file."bin/diff-generations".source = ../scripts/diff-generations;
    };

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
  };
}
