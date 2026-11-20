{ inputs, ... }:

{
  flake-file.inputs.llm-agents = {
    url = "github:numtide/llm-agents.nix";
  };

  flake.modules.nixos.ai = { pkgs, ... }: {
    nix.settings = {
      extra-substituters = [ "https://cache.numtide.com" ];
      extra-trusted-public-keys = [
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];
    };

    # Use the upstream dependency set for compatibility and binary cache hits.
    environment = {
      systemPackages = with pkgs; [
        inputs.llm-agents.packages.${stdenv.hostPlatform.system}.codex
        inputs.llm-agents.packages.${stdenv.hostPlatform.system}.claude-code
        ripgrep
      ];

      variables = {
        ANTHROPIC_BASE_URL = "https://api.deepseek.com/anthropic";

        ANTHROPIC_MODEL = "deepseek-flash[1m]";
        ANTHROPIC_DEFAULT_OPUS_MODEL = "deepseek-flash[1m]";
        ANTHROPIC_DEFAULT_SONNET_MODEL = "deepseek-flash[1m]";
        ANTHROPIC_DEFAULT_HAIKU_MODEL = "deepseek-flash";

        CLAUDE_CODE_SUBAGENT_MODEL = "deepseek-flash";
        CLAUDE_CODE_EFFORT_LEVEL = "max";
        CLAUDE_CODE_AUTO_COMPACT_WINDOW = "786432";
      };
    };
  };
}
