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
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme0n1p1";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
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

  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    bat
    btop
    btrfs-progs
    discord-ptb
    eza
    fastfetch
    fzf
    gamescope
    gcc
    ghostty
    git
    grim
    imv
    killall
    kitty
    mpv
    neovim
    nerd-fonts._0xproto
    nerd-fonts.fira-code
    nerd-fonts.hasklug
    nerd-fonts.iosevka
    nixfmt-rfc-style
    odin
    pavucontrol
    prettier
    python3
    ripgrep
    rofi
    slurp
    swappy
    tealdeer
    transmission_4-gtk
    tree
    tree-sitter
    waybar
    yazi
    zathura
    zathuraPkgs.zathura_cb
    zathuraPkgs.zathura_djvu
    zathuraPkgs.zathura_pdf_mupdf
    zathuraPkgs.zathura_pdf_poppler
    zathuraPkgs.zathura_ps
    zoxide
  ];

  security.doas = {
    enable = true;
    extraRules = [
      {
        groups = [ "doas" ];
        runAs = "root";
        persist = true;
      }
    ];
  };

  services.openssh.enable = true;
  services.blueman.enable = true;
  services.xserver.xkb.layout = "us";
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
