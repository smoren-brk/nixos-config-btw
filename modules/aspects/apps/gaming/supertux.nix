{
  flake.modules.nixos.supertux = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      supertux
      supertuxkart
    ];
  };
}
