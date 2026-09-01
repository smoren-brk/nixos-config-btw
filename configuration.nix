# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    ./hardware-configuration.nix
    ./pkg/packages.nix
    ./pkg/programs.nix
  ];

  home-manager.users.jx = import ./home-manager.nix;

  hardware.bluetooth = {
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

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.device = "/dev/nvme0n1p1";
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "nixos";
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
    EDITOR = "nvim";
    PAGER = "nvim +Man!";
    MANPAGER = "nvim +Man!";
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };

  security = {
    rtkit.enable = true;

    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "doas" ];
          runAs = "root";
          persist = true;
        }
      ];
    };
  };

  services = {
    openssh.enable = true;
    blueman.enable = true;
    xserver.xkb.layout = "us";

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
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.11"; # Did you read the comment?

}
