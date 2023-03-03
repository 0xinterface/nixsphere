{
  description = "My configurations for the Nix ecosystem";

  inputs = {
    # current stable release
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    # rolling release
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # macOS specific nix functions library
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, darwin, nixpkgs, nixpkgs-unstable, home-manager }:
    {
      homeConfigurations = {
        satellite = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          modules = [ ];
	  extraSpecialArgs = { pkgsUnstable = inputs.nixpkgsUnstable.legacyPackages.x86_64-linux; };
        };
	dev = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
	  modules = [ ];
	  extraSpecialArgs = { pkgsUnstable = inputs.nixpkgsUnstable.legacyPackages.x86_64-linux; };
	};
      };

      # nix build .#darwinConfigurations.${hostname}.system
      # ./result/sw/bin/darwin-rebuild switch --flake .
      darwinConfigurations = {
        anemoi = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            home-manager.darwinModules.home-manager
            ./nixpkgs/darwin/anemoi/configuration.nix
          ];
          inputs = { inherit darwin nixpkgs; };
        };
      };

      # sudo nixos-rebuild switch --flake .#${hostname}
      nixosConfigurations = {
        satellite = inputs.nixpkgs.lib.nixosSystem {
          system = "x86-linux";
	  specialArgs = { inherit inputs; };
          modules = [];
	};
	satellite-arm = inputs.nixpkgs.lib.nixosSystem {
	  system = "aarch64-linux";
	  specialArgs = { inherit inputs; };
	  modules = [];
	};
      };
    };
}
