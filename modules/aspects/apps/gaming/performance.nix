{
  flake.modules.nixos.performance = { pkgs, ... }: {
    services.lact.enable = true;

    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings.general = {
        desiredgov = "performance";
        renice = 10;
      };
    };

    users.users.jx.extraGroups = [ "gamemode" ];

    hardware = {
      amdgpu.overdrive.enable = true;
      cpu.amd.ryzen-smu.enable = true;
    };

    environment.systemPackages = with pkgs; [
      gamescope
      mangohud
      vulkan-tools
    ];
  };
}
