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

### Setup

```bash
nix run nix-darwin -- switch --flake ~/.config/nix-dotfiles
```

## Update

Change something and run `switch` in terminal.
