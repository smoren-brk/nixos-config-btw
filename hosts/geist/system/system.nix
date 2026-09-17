{
  config,
  lib,
  pkgs,
  split-monitor-workspaces,
  ...
}:

{
  hardware.i2c.enable = true;

  virtualisation.docker = {
    enable = false;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  boot = {
    loader = {
      limine.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "geist";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Belgrade";

  users.users.jx = {
    isNormalUser = true;
    description = "JX";
    extraGroups = [
      "wheel"
      "doas"
    ];
    home = "/home/jx";
  };

  environment.variables = {
    BROWSER = "firefox";
    TERM = "ghostty";
    TERMINAL = "ghostty";
    NIXOS_OZONE_WL = "1";
  };

  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "doas" ];
          keepEnv = true;
          persist = true;
          runAs = "root";
          users = [ "jx" ];
        }
      ];
    };
  };

  services = {
    xserver.xkb.layout = "us";
    getty.autologinUser = "jx";

    gnome = {
      gcr-ssh-agent.enable = false;
    };
  };

  system.stateVersion = "26.11"; # Did you read the comment?
}
