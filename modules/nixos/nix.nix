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
    nix = {
        package = pkgs.nixUnstable;

        settings = {
            trusted-users = [ sudoGroup ];
            experimental-features = [ "nix-command" "flakes" ];
            auto-optimise-store = true;
        };

        registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
        nixPath = lib.mapAttrsToList (name: flake: "${name}=${flake}") flakeInputs;

        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 30d";
        };
    };
}
