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
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    {
      self,
      nix-darwin,
      home-manager,
      mac-app-util,
      ...
    }:
    {
      darwinConfigurations.adjsky-macbook = import ./darwin.nix {
        inherit
          self
          nix-darwin
          home-manager
          mac-app-util
          ;
      };
    };
}
