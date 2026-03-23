{ pkgs }:
{
  enable = true;
  defaultEditor = true;
  initLua = builtins.readFile ../config/nvim/init.lua;
  plugins = with pkgs.vimPlugins; [
    catppuccin-nvim
  ];
}
