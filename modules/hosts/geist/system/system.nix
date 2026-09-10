{ config
, lib
, pkgs
, split-monitor-workspaces
, ...
}:

{
  hardware = {
    i2c.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };

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
    shell = pkgs.zsh;
    home = "/home/jx";
  };

  environment.variables = {
    BROWSER = "firefox";
    TERM = "ghostty";
    TERMINAL = "ghostty";
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "niri";
  };

  security = {
    rtkit.enable = true;

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
    blueman.enable = true;
    openssh.enable = true;
    xserver.xkb.layout = "us";
    getty.autologinUser = "jx";

    pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "hyprland" ];
      hyprland.default = [ "hyprland" ];
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  system.stateVersion = "26.11"; # Did you read the comment?
}
