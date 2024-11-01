## dotfiles

My personal dotfiles, managed with [Nix Flakes](https://nixos.wiki/wiki/Flakes).

## Install

### Install Nix ([Determinate](https://github.com/DeterminateSystems/nix-installer))

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

### Clone repository

```bash
git clone https://github.com/adjsky/nix-dotfiles.git ~/.config/nix-dotfiles
```

### Setup nix-darwin

```bash
nix run nix-darwin -- switch --flake ~/.config/nix-dotfiles
```

### Setup SSH/Git

1. Generate SSH keys.

```bash
ssh-keygen -t ed25519 -C "pers@mail.com" -f ~/.ssh/pers
ssh-keygen -t ed25519 -C "work@mail.com" -f ~/.ssh/work
```

2. Add the generated keys to GitHub for each account.

3. Clone!

```bash
git clone git@github-pers:adjsky/dotfiles.git
```

## Update

Change something and run `switch` in terminal.
