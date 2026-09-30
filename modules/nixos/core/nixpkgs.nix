{
  pkgs,
  inputs,
  ...
}:
let
  inherit (inputs) self;
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-40.10.5"
      ];
    };

    overlays = (builtins.attrValues self.overlays) ++ [
      (
        final: prev:
        import ../../../pkgs {
          pkgs = prev;
        }
      )
    ];
  };
}
