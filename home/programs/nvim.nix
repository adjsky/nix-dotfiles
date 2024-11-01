{ pkgs }:
{
  enable = true;
  defaultEditor = true;
  extraLuaConfig = builtins.readFile ../config/nvim/init.lua;
  plugins = with pkgs.vimPlugins; [
    catppuccin-nvim
  ];
}
