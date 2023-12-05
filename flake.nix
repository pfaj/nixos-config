{
  description = "NixOS flake configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
    ags.url = "github:Aylur/ags";
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    naersk.url = "github:nix-community/naersk"; # for easy rust builds
    musnix = {url = "github:musnix/musnix";};
    plasma6.url = "github:nix-community/kde2nix";
    neovim-flake.url = "github:jordanisaacs/neovim-flake";
    aylur-dotfiles = {
      url = "github:Aylur/dotfiles";
      flake = false;
    };
  };

  outputs = inputs: let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    system = "x86_64-linux";
    username = "ben";
  in {
    nixosConfigurations = {
      "desktop" = nixosSystem {
        inherit system;
        modules = [
          ./hosts/desktop/configuration.nix
          ({pkgs, ...}: {
            environment.systemPackages = with pkgs; [
              (nixos-update {
                configName = "desktop";
              })
            ];
          })
        ];
        specialArgs = {
          inherit inputs;
          inherit username;
        };
      };

      "surface-laptop" = nixosSystem {
        inherit system;
        modules = [
          ./hosts/surface-laptop/configuration.nix
          ({pkgs, ...}: {
            environment.systemPackages = with pkgs; [
              (nixos-update {
                configName = "surface-laptop";
              })
            ];
          })
        ];
        specialArgs = {
          inherit inputs;
          inherit username;
        };
      };
    };

    nix.settings = {
      builders-use-substitutes = true;

      substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://anyrun.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      ];
    };

    overlays = import ./overlays;
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
  };
}
