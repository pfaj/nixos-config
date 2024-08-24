{
  inputs,
  pkgs,
  lib,
  ...
}: let
  flakeInputs = lib.filterAttrs (_: input: input ? "_type" && input._type == "flake") inputs;
in {
  nix = {
    package = pkgs.nixVersions.git;

    settings = {
      trusted-users = ["@wheel"];
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      keep-derivations = false;
      keep-outputs = false;

      substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://anyrun.cachix.org"
        "https://ben-dotfiles.cachix.org"
        "https://cosmic.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "ben-dotfiles.cachix.org-1:Y61MQvs9FadndHtgNsbF67wX9NNfgf5lx5Bg9XH64DM="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];
    };

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (name: flake: "${name}=${flake}") flakeInputs;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
  };
  system.stateVersion = "24.11";
}
