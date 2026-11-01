{
  flake.modules.nixos.networking = {
    networking = {
      stevenblack = {
        enable = false;
        block = [
          "fakenews"
          "gambling"
          "porn"
        ];
      };
    };
  };
}
