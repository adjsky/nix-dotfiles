{ pkgs, config, ... }:
{
  # Internal compatibility configuration for home-manager, don't change this!
  home.stateVersion = "23.05";

  targets.darwin = {
    linkApps = {
      enable = false;
    };
    copyApps = {
      enable = true;
      enableChecks = false;
    };
  };

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

  xdg.configFile =
    let
      dotfiles = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nix-dotfiles/home/config";
    in
    {
      "zed".source = "${dotfiles}/zed";
      "wezterm".source = "${dotfiles}/wezterm";
    };

  home.packages = with pkgs; [
    nixd
    nixfmt
    deno
    nodejs_24
    devbox
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
    process-compose
    tilt
    werf
    nelm
    yq-go
    bat
    frankenphp
    dust
    docker
    commitizen
    nix-sweep
  ];

  home.file = with config.lib.file; {
    "Programming/pers/.gitconfig".source =
      mkOutOfStoreSymlink
        config.sops.secrets."gitconfig/pers".path;
    "Programming/work/.gitconfig".source =
      mkOutOfStoreSymlink
        config.sops.secrets."gitconfig/work".path;
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
