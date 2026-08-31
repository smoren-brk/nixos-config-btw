{
  pkgs,
  ...
}:

{

  programs.git = {
    enable = true;

    settings = {
      user = {
        email = "sumarac@protonmail.com";
        name = "Jovan Djokic-Sumarac";
      };

      core = {
        compression = 9;
        editor = "nvim";
        whitespace = "error";
        preloadindex = true;
      };

      interactive = {
        diffFilter = "delta --color-only";
      };

      delta = {
        navigate = true;
        dark = true;
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
  };

}
