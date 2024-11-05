{ pkgs, config, ... }:
{
  # Internal compatibility configuration for home-manager, don't change this!
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
    zed-editor
  ];

  # Use the external zed config for quicker hacking.
  xdg.configFile."zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nix-dotfiles/home/config/zed/settings.json";

  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = import ./programs/zsh.nix { inherit config; };
  programs.git = import ./programs/git.nix;
  programs.wezterm = import ./programs/wezterm.nix;
  programs.neovim = import ./programs/nvim.nix { inherit pkgs; };
  programs.ssh = import ./programs/ssh.nix;
}
