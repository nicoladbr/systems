{
  description = "Systems";
  inputs = {
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url  = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = inputs @ { flake-parts, self, ... }:
    let
      darwin = import ./modules/darwin { inherit user; };
      nixos  = import ./modules/nixos  { inherit user; };
      home   = import ./modules/home   { inherit inputs; };

      user = {
        username = "nicola";
        name = "Nicola Di Bernardo";
        email = "nicola.dibernardo";
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" "aarch64-linux" ];

      flake = {
        darwinConfigurations.rigel = inputs.darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            darwin
            inputs.home-manager.darwinModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user.username} = { pkgs, ... }: {
                imports = [ home ];
              };
            }
          ];
        };

       nixosConfigurations.proxima = inputs.nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            nixos
            inputs.home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user.username} = { pkgs, ... }: {
                imports = [
                  home
                  inputs.nixvim.homeManagerModules.nixvim
                ];
              };
            }
          ];
        };
      };

      perSystem = { system, pkgs, lib, ... }: {
        packages.rigel   = self.darwinConfigurations.rigel.system;
        packages.proxima = self.nixosConfigurations.proxima.system;
      };
    };
}
