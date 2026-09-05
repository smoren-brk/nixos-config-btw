{ self, inputs, ... }: {

  flake.nixosModules.geistConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.geistHardware
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
        limine.enable = true;
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
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
      ];
    };

    system.stateVersion = "26.11"; # Did you read the comment?
  };
}
