{ self, inputs, ... }: {
  flake.nixosConfigurations.geist = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.geistConfiguration
    ];
  };
}
