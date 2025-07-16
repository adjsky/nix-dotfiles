{ pkgs, config, ... }:
{
  # Internal compatibility configuration for home-manager, don't change this!
  home.stateVersion = "23.05";

  sops = {
    age.keyFile = "${config.home.homeDirectory}/Library/Application Support/sops/age/keys.txt";
    defaultSopsFile = ../secrets/darwin.yaml;
    secrets = {
      "amneziawg/ams" = { };
      "gitconfig/work" = { };
      "gitconfig/pers" = { };
      "ssh/work/private_key" = { };
      "ssh/pers/private_key" = { };
    };
  };

  xdg.configFile = with config.lib.file; {
    # Use the external zed config for quicker hacking.
    "zed/settings.json".source =
      mkOutOfStoreSymlink "${config.xdg.configHome}/nix-dotfiles/home/config/zed/settings.json";
    "zed/keymap.json".source =
      mkOutOfStoreSymlink "${config.xdg.configHome}/nix-dotfiles/home/config/zed/keymap.json";
  };

  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    deno
    nodejs_24
    devbox
    ngrok
    direnv
    go
    cargo
    rustc
    rustfmt
    rustPlatform.rustLibSrc
    gleam
    erlang_27
    elixir_1_17
    rebar3
    colima
    zed-editor
    slack
    sops
    age
    google-chrome
    just
    bruno
    pnpm
    php84
    php84Packages.composer
    libargon2
    caddy
    rclone
    shellcheck
    shfmt
    laravel
    sqlite
  ];

  home.file = with config.lib.file; {
    "Programming/pers/.gitconfig".source =
      mkOutOfStoreSymlink
        config.sops.secrets."gitconfig/pers".path;
    "Programming/work/.gitconfig".source =
      mkOutOfStoreSymlink
        config.sops.secrets."gitconfig/work".path;
    "AmneziaWG/ams_init.conf" = {
      text = "dummy";
      onChange = ''
        cp ${config.sops.secrets."amneziawg/ams".path} ~/AmneziaWG/ams.conf
        rm ~/AmneziaWG/ams_init.conf
      '';
    };
  };

  home.sessionVariables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
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
