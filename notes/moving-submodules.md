# Moving submodules

Use `git mv old/path new/path` from the parent repository, then check
`git diff --cached` and `git submodule status`. For a normal initialized
submodule, Git updates `.gitmodules` and the local Git directory pointers.

If the directory was already moved manually:

1. Set its `path` in `.gitmodules` to the current location.
2. Fix `<new/path>/.git` to point to the existing directory in `.git/modules/`.
3. Fix `core.worktree` in that directory's `config` to point back to the new
   working directory. Both pointers are relative to the file's directory.
4. If the parent accidentally tracked the submodule's individual files, run
   `git rm -r --cached -- new/path` (keeps files on disk), then
   `git add .gitmodules new/path` to restore the submodule entry.
5. Run `git submodule sync --recursive` and `git submodule status`.

