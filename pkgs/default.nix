{ pkgs, naersk }:
let
    callPackage = pkgs.lib.callPackageWith (pkgs // { inherit naersk; });
in
{
    arrpc = callPackage ./arrpc.nix { };
    hyprland-workspaces = callPackage ./hyprland-workspaces.nix { };
    latencyflex = callPackage ./latencyflex.nix { };
    marwaita-x = callPackage ./marwaita-x.nix { };
    mcmojave-cursors = callPackage ./mcmojave-cursors.nix { };
    nixos-update = callPackage ./nixos-update.nix { };
    sddm-chili = callPackage ./sddm-chili.nix { };
    xwaylandvideobridge = callPackage ./xwaylandvideobridge.nix { };
}
