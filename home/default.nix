{ pkgs, ... }:
{
  # internal compatibility configuration for home-manager, don't change this!
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    deno
    nodejs
    devbox
    ngrok
    direnv
  ];

  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = import ./programs/zsh.nix;
  programs.git = import ./programs/git.nix;
  programs.wezterm = import ./programs/wezterm.nix;
  programs.neovim = import ./programs/nvim.nix { inherit pkgs; };
  programs.ssh = import ./programs/ssh.nix;
}
