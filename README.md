# NixOS hosts

Hosts:

- `loki`: the desktop (formerly `geist`)
- `hela`: a skeleton for the VPS, not yet configured

## Structure

- `modules/aspects/`: reusable capabilities registered under `flake.modules.nixos`.
- `modules/profiles/`: explicit groups of capabilities (`base`, `workstation`,
  `development`, `gaming`).
- `modules/users/`: explicitly selected accounts and personal preferences.
- `modules/hosts/<name>/`: host composition, hardware, and host-specific settings.
- `modules/inputs.nix`: shared flake input declarations.
- `modules/packages/noevf/`: vendored Neovim configuration, installed by the development profile.

## Neovim

Run the configured editor independently of the NixOS hosts:

```sh
nix run .#neovf
nix run github:smoren-brk/nixos-config-btw#neovf
```

The package supports `x86_64-linux` and `aarch64-linux`. Build it with
`nix build .#neovf`, or install it with
`nix profile add github:smoren-brk/nixos-config-btw#neovf`.

