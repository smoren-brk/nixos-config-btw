{
  flake.modules.nixos.audio = { pkgs, ... }: {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    environment.systemPackages = [
      pkgs.pavucontrol
    ];
  };
}
