{ config }:
{
  enable = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  shellAliases = {
    switch = "darwin-rebuild switch --flake path:${config.xdg.configHome}/nix-dotfiles";
  };
  oh-my-zsh = {
    enable = true;
    plugins = [
      "direnv"
      "git"
      "brew"
    ];
    theme = "robbyrussell";
  };
}
