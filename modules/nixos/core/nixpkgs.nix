{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs) self;
in {
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };

    overlays =
      (builtins.attrValues self.overlays)
      ++ [
        (final: prev:
          import ../../../pkgs {
            pkgs = prev;
          })
      ];
  };
}
