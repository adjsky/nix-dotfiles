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

      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 4;

      system.defaults.finder.AppleShowAllExtensions = true;
      system.defaults.finder.AppleShowAllFiles = true;
      system.defaults.finder.FXPreferredViewStyle = "Nlsv";
      system.defaults.finder._FXSortFoldersFirst = true;

      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfree = true;

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
    mac-app-util.darwinModules.default
    configuration
    home-manager.darwinModules.home-manager
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
