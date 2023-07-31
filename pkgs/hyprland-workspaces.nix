{
    naersk,
    fetchFromGitHub,
}:
let
    # nix-prefetch-git https://github.com/bdebiase/hyprland-workspaces.git
    src = fetchFromGitHub {
        owner = "bdebiase";
        repo = "hyprland-workspaces";
        rev = "38dbc69bb82b3c03815606a575f83070049adb58";
        sha256 = "073xw9mx70qdg1dyxcvrm3rnm1n7rs6bgz227j5bsrnj2jb9rdj4";
    };
in
naersk.buildPackage {
    pname = "hyprland-workspaces";
    version = "unstable-2023-07-29";
    src = src;
    root = src;
}
