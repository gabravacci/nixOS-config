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
	    url = "github:nix-community/home-manager";
	    inputs.nixpkgs.follows = "nixpkgs";
	  };

	  hyprland = {
	    url = "github:vaxerski/Hyprland";
	    inputs.nixpkgs.follows = "nixpkgs";
	  };

    gBar = {
      url = "github:scorpion-26/gBar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    # overlays
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
    };

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    rust-overlay.url="github:oxalica/rust-overlay";

    eww.url = "github:elkowar/eww";

    base16 = {
      url = "github:shaunsingh/base16.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16-oxocarbon = {
      url = "github:shaunsingh/base16-oxocarbon";
      flake = false;
    };

    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    eww.inputs.nixpkgs.follows = "nixpkgs"; 
    eww.inputs.rust-overlay.follows = "rust-overlay";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, gBar, ... }:         # Do this with inputs 
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
          specialArgs = {inherit inputs;};
	        modules = [ 
	          ./configuration.nix
            hyprland.nixosModules.default
	          home-manager.nixosModules.home-manager {
	            home-manager.useGlobalPkgs = true;
	            home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit self;
              };
	            home-manager.users.gabe = {
	              imports = [ ./home.nix inputs.base16.hmModule gBar.homeManagerModules.x86_64-linux.default ];
	            };
	          }
	        ]; 
	      };
      };
      
    };
}
