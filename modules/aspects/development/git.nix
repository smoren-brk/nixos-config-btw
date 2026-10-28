{ inputs, config, ... }:

let
  gitModule = config.flake.modules.wrapper.git;
in
{
  flake.modules.nixos.git =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      git =
        (inputs.wrappers.wrapperModules.git.apply {
          inherit pkgs;
          imports = [ gitModule ];

          settings = {
            safe = {
              directory = "${config.users.users.jx.home}/config/";
            };

            core = {
              compression = 9;
              editor = "nvim";
              pager = lib.getExe pkgs.delta;
              whitespace = "error";
              preloadindex = true;
            };

            interactive = {
              diffFilter = "${pkgs.delta}/bin/delta --color-only";
            };

            advice = {
              addEmptyPathSpec = false;
              pushNonFastForward = false;
              statusHints = false;
            };

            merge = {
              conflictStyle = "zdiff3";
              ff = false;
            };

            status = {
              submoduleSummary = true;
              branch = true;
              showStash = true;
              showUntrackedFiles = "all";
            };

            push = {
              autoSetupRemote = true;
              default = "current";
              followTags = true;
            };

            pull = {
              default = "current";
              rebase = true;
            };

            rebase = {
              autoStash = true;
              missingCommitsCheck = "warn";
            };

            log = {
              abbrevCommit = true;
              graphColors = "blue,yellow,cyan,magenta,green,red";
            };

            alias = {
              stat = "status -sb";
              graph = "log --graph --all --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'";
              amend = "commit -S --amend";
              blame = "blame -w -C -C -C";
              maid = "fetch --force --refetch --prune --prune-tags -j6 --progress --all";
              remaster = "!git switch master && git pull -j8";
            };

            init = {
              defaultBranch = "master";
            };

            rerere = {
              enabled = true;
            };

            branch = {
              sort = "-committerdate";
            };
          };

        }).wrapper;
    in
    {
      environment.systemPackages = [
        pkgs.delta
        git
      ];
    };
}
