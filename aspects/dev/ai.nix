{ inputs, ... }:
{
  flake.modules.nixos.ai = { pkgs, ... }: {
    environment.systemPackages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      codex
      dsh
      pkgs.ripgrep
    ];
  };
}
