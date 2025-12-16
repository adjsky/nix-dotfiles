{
  self,
  nix-darwin,
  home-manager,
  sops-nix,
  ...
}:
let
  username = "adjsky";
  homedir = "/Users/${username}";
  configuration =
    { pkgs, ... }:
    {
      nix.settings.experimental-features = "nix-command flakes";

      nixpkgs = {
        hostPlatform = "aarch64-darwin";
        config = {
          allowUnfree = true;
        };
      };

      system = {
        configurationRevision = self.rev or self.dirtyRev or null;
        stateVersion = 5;
        primaryUser = username;
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
        mru-spaces = false;

        persistent-apps = [
          "/Applications/Zen.app"
          "${pkgs.vscode}/Applications/Visual Studio Code.app"
          "${pkgs.wezterm}/Applications/WezTerm.app"
        ];
      };

      system.activationScripts.extraActivation.text = ''
        softwareupdate --install-rosetta --agree-to-license
      '';

      users.users.${username} = {
        name = username;
        home = homedir;
      };

      security.pam.services.sudo_local.touchIdAuth = true;

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      homebrew = {
        enable = true;

        onActivation = {
          cleanup = "zap";
          autoUpdate = true;
          upgrade = true;
        };

        casks = [
          "zed"
          "amneziavpn"
          "zen"
          "tableplus"
        ];

        masApps = {
          Outline = 1356178125;
          Yomu = 562211012;
        };
      };
    };
in
nix-darwin.lib.darwinSystem {
  modules = [
    configuration
    home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.verbose = true;
      home-manager.users.${username} = import ./home;
      home-manager.sharedModules = [
        sops-nix.homeManagerModules.sops
      ];
    }
  ];
}
