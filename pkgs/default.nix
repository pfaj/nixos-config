{ pkgs, naersk }:
let
    callPackage = pkgs.lib.callPackageWith (pkgs // { inherit naersk; });
in
{
    hyprland-workspaces = callPackage ./hyprland-workspaces.nix { };
    marwaita-x = callPackage ./marwaita-x.nix { };
    mcmojave-cursors = callPackage ./mcmojave-cursors.nix { };
    sddm-chili = callPackage ./sddm-chili.nix { };
    xwaylandvideobridge = callPackage ./xwaylandvideobridge.nix { };
}
