{
  self,
  nix-darwin,
  home-manager,
  ...
}:
let
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
      nixpkgs.hostPlatform = "aarch64-darwin";

      nixpkgs.config.allowUnfree = true;

      # Declare the user that will be running `nix-darwin`.
      users.users.adjsky = rec {
        name = "adjsky";
        home = "/Users/${name}";
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
in
nix-darwin.lib.darwinSystem {
  modules = [
    configuration
    home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.verbose = true;
      home-manager.users.adjsky = import ./home;
    }
  ];
}
