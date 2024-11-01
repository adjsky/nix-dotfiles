{
  enable = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  shellAliases = {
    switch = "darwin-rebuild switch --flake path:$HOME/.config/nix-dotfiles";
  };
  oh-my-zsh = {
    enable = true;
    plugins = [
      "direnv"
      "git"
    ];
    theme = "robbyrussell";
  };
}
