# geist

Run from this directory:

```sh
nix flake update
sudo nixos-rebuild switch --flake .
```

After the system is bootstrapped, use:

```sh
nh os switch --upgrade
```

## Flake inputs

Inputs are to be added the module's declaration, or inside `modules/inputs.nix`.

Regenerate the flake file after each input addition.

```sh
nix run .#write-flake
```

## Structure

`aspects/` contains reusable app, desktop, development, system, and terminal modules.

`modules` contains flake-file declarations.

`hosts/` contains each host's configuration, hardware, and users.

