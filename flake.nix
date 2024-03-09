{
  description = "Systems";
  inputs = {
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ { flake-parts, self, ... }:
    let
      darwin        = import ./modules/darwin { inherit user; };
      home-manager  = import ./modules/home-manager  { inherit inputs; };

      user = {
        username = "nicola";
        name = "Nicola Di Bernardo";
        email = "nicola.dibernardo";
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin"];

      flake = {
        darwinConfigurations.rigel = inputs.darwin.lib.darwinSystem {
        modules = [
            darwin
            inputs.home-manager.darwinModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user.username} = { pkgs, ... }: {
                imports = [ home-manager ];
              };
            }
          ];
          system = "aarch64-darwin";
        };
      };

      perSystem = { system, pkgs, lib, ... }: {
        packages.rigel = self.darwinConfigurations.rigel.system;
      };
    };
}
