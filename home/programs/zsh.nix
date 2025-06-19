{ config }:
{
  enable = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  shellAliases = {
    switch = "darwin-rebuild switch --flake path:${config.xdg.configHome}/nix-dotfiles";
  };
  initContent = builtins.readFile ../config/zsh.sh;
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
