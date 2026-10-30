{
  flake.modules.nixos.networking = {
    networking = {
      stevenblack = {
        enable = true;
        block = [
          "fakenews"
          "gambling"
          "porn"
        ];
      };
    };
  };
}
