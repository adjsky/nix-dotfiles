{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
    }:
    let
      platform = "aarch64-darwin";
      configuration =
        { pkgs, ... }:
        {
          services.nix-daemon.enable = true;

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility. please read the changelog 
          # before changing: `darwin-rebuild changelog`.
          system.stateVersion = 4;

          # The platform the configuration will be used on.
          # If you're on an older system, replace with "x86_64-darwin"
          nixpkgs.hostPlatform = platform;

          nixpkgs.config.allowUnfree = true;

          # Declare the user that will be running `nix-darwin`.
          users.users.adjsky = {
            name = "adjsky";
            home = "/Users/adjsky";
          };

          security.pam.enableSudoTouchIdAuth = true;

          # Create /etc/zshrc that loads the nix-darwin environment. 
          programs.zsh.enable = true;

          environment.systemPackages = with pkgs; [
            nixd
            nixfmt-rfc-style
          ];

          fonts.packages = with pkgs; [ jetbrains-mono ];
        };
      homeconfig =
        { pkgs, ... }:
        {
          # this is internal compatibility configuration for home-manager, 
          # don't change this!
          home.stateVersion = "23.05";
          # Let home-manager install and manage itself.
          programs.home-manager.enable = true;

          home.packages = with pkgs; [
            deno
            nodejs
            devbox
            ngrok
          ];

          programs.zsh = {
            enable = true;
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;
            shellAliases = {
              switch = "darwin-rebuild switch --flake path:$HOME/.config/nix-dotfiles";
            };
            oh-my-zsh = {
              enable = true;
              plugins = [
                "direnv"
                "git"
              ];
              theme = "robbyrussell";
            };
          };

          programs.git = {
            enable = true;
            extraConfig = {
              pull.rebase = true;
              fetch.prune = true;
              diff.colorMoved = "zebra";
              push.default = "current";
              core.editor = "nvim";
              includeif."gitdir:~/Programming/work/".path = "~/Programming/work/.gitconfig";
              includeif."gitdir:~/Programming/pers/".path = "~/Programming/pers/.gitconfig";
            };
          };

          programs.wezterm = {
            enable = true;
            extraConfig = builtins.readFile ./dotfiles/wezterm/wezterm.lua;
          };

          programs.neovim = {
            enable = true;
            defaultEditor = true;
            extraLuaConfig = builtins.readFile ./dotfiles/nvim/init.lua;
            plugins = with pkgs.vimPlugins; [
              catppuccin-nvim
            ];
          };

          programs.ssh = {
            enable = true;
            matchBlocks = {
              "github-pers" = {
                hostname = "ssh.github.com";
                port = 443;
                identityFile = "~/.ssh/pers";
                identitiesOnly = true;
              };
              "github-work" = {
                hostname = "ssh.github.com";
                port = 443;
                identityFile = "~/.ssh/work";
                identitiesOnly = true;
              };
            };
          };
        };
    in
    {
      darwinConfigurations.adjsky-macbook = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.adjsky = homeconfig;
          }
        ];
      };
      formatter.${platform} = nixpkgs.legacyPackages.${platform}.nixfmt-rfc-style;
    };
}
