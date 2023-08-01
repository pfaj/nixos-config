{ pkgs, naersk }:
let
    callPackage = pkgs.lib.callPackageWith (pkgs // { inherit naersk; });
in
{
    xwaylandvideobridge = callPackage ./xwaylandvideobridge.nix { };
    hyprland-workspaces = callPackage ./hyprland-workspaces.nix { };
}
