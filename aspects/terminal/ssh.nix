{
  flake.modules.nixos.ssh = {
    programs.ssh = {
      startAgent = true;
      agentTimeout = "8h";
    };

    services.gnome.gcr-ssh-agent.enable = false;
  };

  flake.modules.homeManager.ssh = {
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
  };
}
