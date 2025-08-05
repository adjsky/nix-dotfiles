.PHONY: nix
nix:
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

.PHONY: homebrew
homebrew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

.PHONY: init
init: nix homebrew
	nix run nix-darwin -- switch --flake .

.PHONY: bump/flake
bump/flake:
	nix flake update

.PHONY: bump/brew
bump/brew:
	brew upgrade --cask --greedy

.PHONY: bump
bump: bump/flake bump/brew
