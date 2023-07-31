{
    inputs,
    pkgs,
    lib,
    ...
}:
let
    flakeInputs = lib.filterAttrs (_: input: input ? "_type" && input._type == "flake") inputs;
    sudoGroup = "@wheel";
in
{
    nix.settings = {
        trusted-users = [ sudoGroup ];
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
    };

    nix.registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nix.nixPath = lib.mapAttrsToList (name: flake: "${name}=${flake}") flakeInputs;

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };
}
