# NixOS configurations setup as follows:
# 
# flake.nix *
#  └─ gabe
#      ├─ ./configuration.nix
#      └─ ./home.nix
#
# Remember to KISS!

{
  description = "Personal NixOS Flake Configuration";

  inputs = {
        #nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11"; # Nix Packages
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Change to unstableu

	home-manager = {      			          # User-level pkgs
	  url = github:nix-community/home-manager;
	  inputs.nixpkgs.follows = "nixpkgs";
	};

	hyprland = {
	  url = "github:vaxerski/Hyprland";
	  inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }:         # Do this with inputs 
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
	inherit system;
	config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in {                                                  
      nixosConfigurations = {
	gabe = lib.nixosSystem {
	  inherit system;
	  modules = [ 
	    ./configuration.nix
            hyprland.nixosModules.default
	    home-manager.nixosModules.home-manager {
	      home-manager.useGlobalPkgs = true;
	      home-manager.useUserPackages = true;
	      home-manager.users.gabe = {
	        imports = [ ./home.nix ];
	      };
	    }
	  ]; 
	};
      };
  };
}
