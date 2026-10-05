# geist

Run from this directory:

```sh
nix flake update
sudo nixos-rebuild switch --flake .#geist
```

After the system is bootstrapped, use:

```sh
nh os switch --upgrade
```


## Structure

`aspects/` contains reusable app, desktop, development, system, and terminal modules.
`hosts/` contains each host's configuration, hardware, and users.

