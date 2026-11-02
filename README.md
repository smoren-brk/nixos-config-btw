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

