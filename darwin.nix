{
  self,
  nix-darwin,
  home-manager,
  mac-app-util,
  ...
}:
let
  username = "adjsky";
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

        activationScripts.extraActivation.text = ''
          softwareupdate --install-rosetta --agree-to-license
        '';

        defaults = {
          finder = {
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
            FXPreferredViewStyle = "Nlsv";
            _FXSortFoldersFirst = true;
          };

          dock = {
            persistent-apps = [
              "${pkgs.zen-browser}/Applications/Zen Browser.app"
              "${pkgs.vscode}/Applications/Visual Studio Code.app"
              "${pkgs.wezterm}/Applications/WezTerm.app"
              "${pkgs.slack}/Applications/Slack.app"
            ];
          };
        };
      };

      users.users.${username} = {
        name = username;
        home = "/Users/${username}";
      };

      security.pam.enableSudoTouchIdAuth = true;

      fonts.packages = with pkgs; [
        (nerdfonts.override {
          fonts = [
            "JetBrainsMono"
          ];
        })
      ];
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
      ];
    }
  ];
}
