{ pkgs, ... }:

{
  programs = {
    firefox.enable = true;

    ssh = {
      startAgent = true;
      agentTimeout = "8h";
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };

  };

}
