{
    naersk,
    fetchFromGitHub,
    rust-analyzer-unwrapped,
    gcc,
    glib,
    gdk-pixbuf,
    librsvg,
    libdbusmenu-gtk3,
    gtk3,
    gtk-layer-shell,
    pkg-config,
    deno,
    mdbook,
}:
let
    # nix-prefetch-git https://github.com/ralismark/eww.git --rev refs/heads/tray-3
    src = fetchFromGitHub { ### fork of 'eww' with system-tray support
        owner = "ralismark";
        repo = "eww";
        rev = "aae214f51f4c8d8129cd0b8dbd0e1c362c50ce27";
        sha256 = "0vc7mi1498mm2lh73fdpbhi6g509rvm40p7xw4m736p5mchsky3g";
    };
in
naersk.buildPackage {
    pname = "eww";
    version = "unstable-2023-07-09";
    src = src;
    root = src;
    cargoBuildOptions = old: old ++ [ "--no-default-features" "--features=wayland" ];
    buildInputs = [
        rust-analyzer-unwrapped
        gcc
        glib
        gdk-pixbuf
        librsvg
        libdbusmenu-gtk3
        gtk3
        gtk-layer-shell
        pkg-config
        deno
        mdbook
    ];
}
