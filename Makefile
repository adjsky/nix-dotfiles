.PHONY: nix
nix:
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

.PHONY: homebrew
homebrew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

.PHONY: terminfo
terminfo:
	tempfile=$(mktemp) \
  		&& curl -o $tempfile https://raw.githubusercontent.com/wezterm/wezterm/main/termwiz/data/wezterm.terminfo \
  		&& tic -x -o ~/.terminfo $tempfile \
  		&& rm $tempfile

.PHONY: init
init: nix homebrew terminfo
	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
	sudo nix run nix-darwin -- switch --flake .

.PHONY: bump/flake
bump/flake:
	nix flake update

.PHONY: bump/brew
bump/brew:
	brew upgrade --cask --greedy

.PHONY: bump
bump: bump/flake bump/brew
