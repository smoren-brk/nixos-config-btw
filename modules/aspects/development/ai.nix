# { inputs, ... }:

{
  # flake-file.inputs.llm-agents = {
  #   url = "github:numtide/llm-agents.nix";
  # };

  flake.modules.nixos.ai = { pkgs, ... }: {
    # nix.settings = {
    #   extra-substituters = [ "https://cache.numtide.com" ];
    #   extra-trusted-public-keys = [
    #     "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    #   ];
    # };

    environment.systemPackages = with pkgs; [
      (codex.overrideAttrs (old: {
        # Backport https://github.com/NixOS/nixpkgs/pull/584667.
        buildInputs = (old.buildInputs or [ ]) ++ [
          pkgs.aws-lc
          pkgs.oniguruma
          pkgs.sqlite
          pkgs.zstd
        ];
      }))
      ripgrep
    ];
  };
}
