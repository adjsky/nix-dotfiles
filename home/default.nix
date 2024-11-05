{ pkgs, ... }:
{
  # internal compatibility configuration for home-manager, don't change this!
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    nixfmt-rfc-style
    deno
    nodejs_23
    devbox
    ngrok
    direnv
    go
    cargo
    rustc
    gleam
    erlang_27
    elixir_1_17
    rebar3
    tableplus
    colima
  ];

  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = import ./programs/zsh.nix;
  programs.git = import ./programs/git.nix;
  programs.wezterm = import ./programs/wezterm.nix;
  programs.neovim = import ./programs/nvim.nix { inherit pkgs; };
  programs.ssh = import ./programs/ssh.nix;
  programs.zed-editor = import ./programs/zed.nix;
}
