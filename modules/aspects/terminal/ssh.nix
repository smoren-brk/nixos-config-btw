{ inputs, ... }:

{
  flake.modules.nixos.ssh =
    { pkgs, ... }:
    let
      sshConfig = pkgs.writeText "ssh-config" ''
        Host *
          AddKeysToAgent yes
          IdentityFile ~/.ssh/nixoskey
      '';
    in
    {
      programs.ssh = {
        package = inputs.wrappers.lib.wrapPackage {
          inherit pkgs;
          package = pkgs.openssh;
          flags."-F" = sshConfig;
        };
        startAgent = true;
        agentTimeout = "8h";
      };

      services.gnome.gcr-ssh-agent.enable = false;
    };
}
