{
  self,
  nix-darwin,
  home-manager,
  mac-app-util,
  sops-nix,
  ...
}:
let
  username = "adjsky";
  homedir = "/Users/${username}";
  configuration =
    { pkgs, ... }:
    {
      services.nix-daemon.enable = true;

      nix.settings.experimental-features = "nix-command flakes";

      nixpkgs = {
        hostPlatform = "aarch64-darwin";
        config = {
          allowUnfree = true;
        };
        overlays = [
          (import ./overlays)
        ];
      };

      system = {
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 4;
      };

      system.defaults.finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXPreferredViewStyle = "Nlsv";
        _FXSortFoldersFirst = true;
      };

      system.defaults.CustomUserPreferences."com.apple.finder" = {
        NewWindowTarget = "PfHm"; # new windows open in home dir
      };

      system.defaults.dock = {
        persistent-apps = [
          "${pkgs.zen-browser}/Applications/Zen Browser.app"
          "${pkgs.vscode}/Applications/Visual Studio Code.app"
          "${pkgs.wezterm}/Applications/WezTerm.app"
          "${pkgs.slack}/Applications/Slack.app"
        ];
      };

      system.activationScripts.extraActivation.text = ''
        softwareupdate --install-rosetta --agree-to-license
      '';

      users.users.${username} = {
        name = username;
        home = homedir;
      };

      security.pam.enableSudoTouchIdAuth = true;

      fonts.packages = with pkgs; [
        (nerdfonts.override {
          fonts = [
            "JetBrainsMono"
          ];
        })
      ];

      homebrew = {
        enable = true;
        masApps = {
          Outline = 1356178125;
          AmneziaWG = 6478942365;
        };
      };
    };
in
nix-darwin.lib.darwinSystem {
  modules = [
    configuration
    home-manager.darwinModules.home-manager
    mac-app-util.darwinModules.default
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.verbose = true;
      home-manager.users.${username} = import ./home;
      home-manager.sharedModules = [
        mac-app-util.homeManagerModules.default
        sops-nix.homeManagerModules.sops
      ];
    }
  ];
}
