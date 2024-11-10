## dotfiles

My personal dotfiles, managed with [Nix Flakes](https://nixos.wiki/wiki/Flakes).

## Install

### Clone repository

```bash
git clone https://github.com/adjsky/nix-dotfiles.git ~/.config/nix-dotfiles
```

### Configure age keys

```bash
mkdir -p ~/Library/Application\ Support/sops/age
cat <<EOF > ~/Library/Application\ Support/sops/age/keys.txt
# created: <timestamp>
# public key: <public_key>
AGE-SECRET-KEY-<private_key>
EOF
```

### Run make

```bash
make init
```

## Hints

### Git

#### SSH schema with a custom hostname

```bash
git clone git@github-pers:adjsky/dotfiles.git
```

### Nix

#### Update flake.lock

```bash
nix flake update
```

#### Rebuild system

```bash
switch
```
