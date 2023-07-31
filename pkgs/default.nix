{ pkgs, naersk }:
let
    callPackage = pkgs.lib.callPackageWith (pkgs // { inherit naersk; });
in
{
    xwaylandvideobridge = callPackage ./xwaylandvideobridge.nix { };
    eww = callPackage ./eww.nix { };
    hyprland-workspaces = callPackage ./hyprland-workspaces.nix { };
}
