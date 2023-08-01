{
    description = "NixOS flake configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland = {
            url = "github:hyprwm/Hyprland";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland-contrib = {
            url = "github:hyprwm/contrib";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        eww = {
            url = "github:ralismark/eww/tray-3";
        };
        anyrun = {
            url = "github:Kirottu/anyrun";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        naersk.url = "github:nix-community/naersk"; # for easy rust builds
        hyprland-workspaces = {
            url = "github:bdebiase/hyprland-workspaces";
            flake = false;
        };
    };

    outputs = { self, nixpkgs, home-manager, flake-utils, hyprland, hyprland-contrib, eww, anyrun, naersk, hyprland-workspaces } @ inputs:
    let
        inherit (flake-utils.lib) eachDefaultSystem;
        inherit (nixpkgs.lib) nixosSystem;
    in
    {
        nixosConfigurations = {
		"desktop" = nixpkgs.lib.nixosSystem {
		    system = "x86_64-linux";
		    modules = [ ./hosts/desktop/configuration.nix ];
		    specialArgs = { inherit inputs; };
		};
		
		"surface-laptop" = nixpkgs.lib.nixosSystem {
            		system = "x86_64-linux";
            		modules = [ ./hosts/surface-laptop/configuration.nix ];
            		specialArgs = { inherit inputs; };
        	};
	};

        nix.settings = {
            builders-use-substitutes = true;
            substituters = [
                "https://hyprland.cachix.org"
                "https://anyrun.cachix.org"
            ];
            trusted-public-keys = [
                "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
            ];
        };

        overlays = import ./overlays;
        nixosModules = import ./modules/nixos;
        homeManagerModules = import ./modules/home-manager;
    };
}
