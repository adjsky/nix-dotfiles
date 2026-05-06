{ pkgs }:
{
  enable = true;
  defaultEditor = true;
  initLua = builtins.readFile ../config/nvim/init.lua;
  plugins = with pkgs.vimPlugins; [
    catppuccin-nvim
  ];
  withPython3 = true;
  withRuby = false;
}
