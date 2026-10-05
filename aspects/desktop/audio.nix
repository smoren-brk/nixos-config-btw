{
  flake.modules.nixos.audio = { pkgs, ... }: {
    security.rtkit.enable = true;

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
