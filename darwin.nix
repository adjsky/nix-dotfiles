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

      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfree = true;

      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 4;

      system.activationScripts.extraActivation.text = ''
        softwareupdate --install-rosetta --agree-to-license
      '';

      system.defaults.finder.AppleShowAllExtensions = true;
      system.defaults.finder.AppleShowAllFiles = true;
      system.defaults.finder.FXPreferredViewStyle = "Nlsv";
      system.defaults.finder._FXSortFoldersFirst = true;

      system.defaults.dock.persistent-apps = [
        "/System/Applications/Launchpad.app"
        # Assume zen browser is installed, manage it declaratively in some time...
        "/Applications/Zen Browser.app"
        "${pkgs.vscode}/Applications/Visual Studio Code.app"
        "${pkgs.wezterm}/Applications/WezTerm.app"
        "${pkgs.slack}/Applications/Slack.app"
      ];

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
