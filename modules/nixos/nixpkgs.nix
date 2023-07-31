{ pkgs, inputs, ... }:
let
    inherit (inputs) self;

    makeEwwOverlay = final: prev: { # TODO: move this to a modular system, idfk how
        eww = (inputs.eww.packages.${final.system}.eww.override { inherit (prev) rustPlatform; }).overrideAttrs (old: {
            buildInputs = old.buildInputs ++ (with final; [ prev.glib prev.librsvg prev.libdbusmenu-gtk3 ]);
        });
        eww-wayland = final.eww.override { withWayland = true; };
    };
in
{
    nixpkgs = {
        config.allowUnfree = true;
        overlays =
            (builtins.attrValues self.overlays)
            ++ [ (final: prev: import ../../pkgs { pkgs = prev; naersk = pkgs.callPackage inputs.naersk { }; }) ]
            ++ [ makeEwwOverlay ];
    };
}
