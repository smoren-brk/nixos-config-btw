{ pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    package = null;
    enableDefaultConfig = false;

    settings = {
      "Host *" = {
        AddKeysToAgent = "yes";
        IdentityFile = "~/.ssh/nixoskey";
      };
    };
  };
}
