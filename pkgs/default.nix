{pkgs}: let
  callPackage = pkgs.lib.callPackageWith pkgs;
in {
  auto-cpufreq = callPackage ./auto-cpufreq.nix {};
  bkqs = callPackage ./bkqs.nix {};
  marwaita-x = callPackage ./marwaita-x.nix {};
  editconf = callPackage ./editconf.nix {};
  intellijpatch = callPackage ./intellijpatch.nix {};
  mcmojave-cursors = callPackage ./mcmojave-cursors.nix {};
  nixos-update = callPackage ./nixos-update.nix {};
  rmshit = callPackage ./rmshit.nix {};
  sddm-chili = callPackage ./sddm-chili.nix {};
}
