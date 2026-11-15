# neovf

Neovim configuration vendored from [smoren-brk/neovf](https://github.com/smoren-brk/neovf)
at `efc7be0c5998de526ec568867d8aeff46f4d607d`, configured with
[nvf](https://github.com/notashelf/nvf).
The parent repository exposes it as `packages.${system}.neovf` for
`x86_64-linux` and `aarch64-linux` and installs it in the development profile.

From the repository root:

```sh
nix run .#neovf
nix build .#neovf
```

