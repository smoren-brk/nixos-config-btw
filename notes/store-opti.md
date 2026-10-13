# Cleaning

## Collect garbage

```bash
doas nix-collect-garbage
```

## Remove all but latest 3 generations

```bash
doas nix-env --profile /nix/var/nix/profiles/system --delete-generations +3
doas nix-collect-garbage
```

## Remove everything but last 2 days

```bash
doas nix-collect-garbage --delete-older-than 2d
```
