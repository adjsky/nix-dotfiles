{ pkgs, config, ... }:
{
  # Internal compatibility configuration for home-manager, don't change this!
  home.stateVersion = "23.05";

  sops = {
    age.keyFile = "${config.home.homeDirectory}/Library/Application Support/sops/age/keys.txt";
    defaultSopsFile = ../secrets/darwin.yaml;
    secrets = {
      "gitconfig/work" = { };
      "gitconfig/pers" = { };
      "ssh/work/private_key" = { };
      "ssh/pers/private_key" = { };
    };
  };

  home.packages = with pkgs; [
    nixd
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
    slack
    zen-browser
    sops
    age
  ];

  xdg.configFile = with config.lib.file; {
    # Use the external zed config for quicker hacking.
    "zed/settings.json".source = mkOutOfStoreSymlink "${config.xdg.configHome}/nix-dotfiles/home/config/zed/settings.json";
    "zed/keymap.json".source = mkOutOfStoreSymlink "${config.xdg.configHome}/nix-dotfiles/home/config/zed/keymap.json";
  };

  home.file = with config.lib.file; {
    "Programming/pers/.gitconfig".source =
      mkOutOfStoreSymlink
        config.sops.secrets."gitconfig/pers".path;
    "Programming/work/.gitconfig".source =
      mkOutOfStoreSymlink
        config.sops.secrets."gitconfig/work".path;
  };

  programs = {
    # Let home-manager install and manage itself.
    home-manager.enable = true;

    zsh = import ./programs/zsh.nix { inherit config; };
    git = import ./programs/git.nix;
    wezterm = import ./programs/wezterm.nix;
    neovim = import ./programs/nvim.nix { inherit pkgs; };
    ssh = import ./programs/ssh.nix { inherit config; };
    vscode = import ./programs/vscode.nix;
  };
}
