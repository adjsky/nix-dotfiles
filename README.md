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

```bash
git clone git@github-pers:adjsky/dotfiles.git
```
