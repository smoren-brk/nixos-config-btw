{
  flake.modules.nixos.overclock-undervolt = { pkgs, ... }: {
    services.lact.enable = true;
    hardware.amdgpu.overdrive.enable = true;

    environment.systemPackages = with pkgs; [
      gamescope
      mangohud
      proton-ge-bin
    ];
  };
}
